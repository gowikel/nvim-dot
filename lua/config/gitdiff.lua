-- Branch list for a branch diff, ordered so the branch the current branch was
-- most likely created from comes first and is therefore preselected.
local M = {}

---@param args string[]
---@return string?
local function git(args)
  local ret = vim.system({ "git", unpack(args) }, { text = true }):wait()
  if ret.code ~= 0 then
    return
  end
  return vim.trim(ret.stdout)
end

---@class gitdiff.Branch
---@field ref string full refname
---@field branch string short name, e.g. main or origin/main
---@field remote boolean
---@field ahead number commits this branch has that HEAD does not
---@field commit string
---@field date string
---@field author string
---@field msg string

---@return gitdiff.Branch[]
local function branches()
  local out = git({
    "for-each-ref",
    "--format=%(refname)\t%(refname:short)\t%(symref)\t%(ahead-behind:HEAD)\t%(objectname:short)"
      .. "\t%(committerdate:relative)\t%(authorname)\t%(contents:subject)",
    "refs/heads",
    "refs/remotes",
  }) or ""
  local ret = {} ---@type gitdiff.Branch[]
  for line in out:gmatch("[^\n]+") do
    local ref, name, symref, ahead, commit, date, author, msg =
      line:match("^([^\t]+)\t([^\t]+)\t([^\t]*)\t(%d+) %d+\t([^\t]+)\t([^\t]*)\t([^\t]*)\t(.*)$")
    -- symbolic refs (origin/HEAD) have no history of their own
    if ref and symref == "" then
      ret[#ret + 1] = {
        ref = ref,
        branch = name,
        remote = ref:find("^refs/remotes/") ~= nil,
        ahead = tonumber(ahead),
        commit = commit,
        date = date,
        author = author,
        msg = msg,
      }
    end
  end
  return ret
end

local trunk = { main = 1, master = 2, develop = 3, trunk = 4 }

--- Tie-break for equally distant candidates: trunk names first, then local
--- branches over remote-tracking ones.
---@param b gitdiff.Branch
local function rank(b)
  local short = b.branch:gsub("^[^/]+/", "")
  return { trunk[short] or (b.remote and 6 or 5), b.remote and 1 or 0, b.branch }
end

--- Closest fork point: the candidate that has moved least past our merge base.
---@param a gitdiff.Branch
---@param b gitdiff.Branch
local function closer(a, b)
  if a.ahead ~= b.ahead then
    return a.ahead < b.ahead
  end
  local ra, rb = rank(a), rank(b)
  for i = 1, 2 do
    if ra[i] ~= rb[i] then
      return ra[i] < rb[i]
    end
  end
  return ra[3] < rb[3]
end

--- The branch the current branch was most likely created from.
---@return string?
function M.likely_base()
  local current = git({ "branch", "--show-current" })
  if not current or current == "" then
    return
  end

  local list = branches()
  local known = {}
  for _, b in ipairs(list) do
    known[b.branch] = true
  end

  -- 1. exact: git records where a branch was created
  local reflog = git({ "reflog", "show", "--format=%gs", current }) or ""
  for line in reflog:gmatch("[^\n]+") do
    local from = line:match("^branch: Created from (.+)$")
    if from and known[from] then
      return from
    end
  end

  -- 2. the branch this one tracks, unless that is its own remote
  local upstream = git({ "rev-parse", "--abbrev-ref", "@{upstream}" })
  if upstream and known[upstream] and upstream:gsub("^[^/]+/", "") ~= current then
    return upstream
  end

  -- 3. the branch whose tip sits closest to our fork point
  local best
  for _, b in ipairs(list) do
    if b.branch ~= current and (not best or closer(b, best)) then
      best = b
    end
  end
  return best and best.branch
end

---@param base? string
---@return snacks.picker.finder.Item[]
function M.branches(base)
  local current = git({ "branch", "--show-current" })
  local root = git({ "rev-parse", "--show-toplevel" })
  local ret = {} ---@type snacks.picker.finder.Item[]
  for _, b in ipairs(branches()) do
    if b.branch ~= current then
      ret[#ret + 1] = {
        text = table.concat({ b.branch, b.commit, b.msg, b.author }, " "),
        cwd = root,
        branch = b.branch,
        commit = b.commit,
        date = b.date,
        author = b.author,
        msg = b.msg,
      }
    end
  end

  table.sort(ret, function(a, b)
    return a.branch < b.branch
  end)
  for i, item in ipairs(ret) do
    if item.branch == base then
      table.insert(ret, 1, table.remove(ret, i))
      break
    end
  end
  return ret
end

function M.open()
  local root = git({ "rev-parse", "--show-toplevel" })
  if not root then
    Snacks.notify.warn("Not inside a git work tree")
    return
  end

  local base = M.likely_base()
  local items = M.branches(base)
  if #items == 0 then
    Snacks.notify.warn("No other branches to diff against")
    return
  end

  Snacks.picker.pick({
    source = "git_branches",
    cwd = root,
    title = "Diff against branch" .. (base and (" (likely " .. base .. ")") or ""),
    finder = function()
      return items
    end,
    confirm = function(picker, item)
      picker:close()
      if item and item.branch then
        Snacks.picker.git_diff({ base = item.branch, group = true })
      end
    end,
  })
end

return M
