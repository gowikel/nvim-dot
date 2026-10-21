-- neotest-python picks pytest whenever pytest is importable, which hijacks
-- Django projects that also have pytest installed. Prefer Django's own runner
-- where the project says it is a Django project, unless the repo configures
-- pytest explicitly -- then the project has already made the choice.
local function finds_upwards(path, predicate)
  local dir = path and path ~= "" and vim.fn.fnamemodify(path, ":p:h") or vim.uv.cwd()
  for _ = 1, 12 do
    if not dir or dir == "" then
      return false
    end
    if predicate(dir) then
      return true
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      return false
    end
    dir = parent
  end
  return false
end

local function file_contains(file, pattern)
  if vim.fn.filereadable(file) ~= 1 then
    return false
  end
  local ok, lines = pcall(vim.fn.readfile, file)
  return ok and table.concat(lines, "\n"):match(pattern) ~= nil
end

local function is_django_project(dir)
  return vim.fn.filereadable(dir .. "/manage.py") == 1
end

local function is_pytest_project(dir)
  return vim.fn.filereadable(dir .. "/pytest.ini") == 1
    or vim.fn.filereadable(dir .. "/tox.ini") == 1
    or file_contains(dir .. "/pyproject.toml", "%[tool%.pytest")
    or file_contains(dir .. "/setup.cfg", "%[tool:pytest%]")
end

local function python_adapter()
  return require("neotest-python")({
    runner = function(python_command)
      local candidates = { vim.api.nvim_buf_get_name(0), vim.uv.cwd() }
      for _, path in ipairs(candidates) do
        if finds_upwards(path, is_django_project) and not finds_upwards(path, is_pytest_project) then
          return "django"
        end
      end
      -- Anything else keeps neotest-python's own detection, which checks the
      -- installed modules in the project's interpreter.
      return require("neotest-python.base").get_runner(python_command)
    end,
  })
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "fredrikaverpil/neotest-golang",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
      "rouge8/neotest-rust",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        python_adapter(),
        require("neotest-golang"),
        require("neotest-jest"),
        require("neotest-vitest"),
        require("neotest-playwright").adapter({}),
        require("neotest-rust"),
      })
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
    },
  },
}
