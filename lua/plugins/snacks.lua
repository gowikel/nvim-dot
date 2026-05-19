return {
  "folke/snacks.nvim",
  init = function()
    local group = vim.api.nvim_create_augroup("snacks_explorer_autoopen", { clear = true })

    local function explorer_is_open()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype
        if ft:match("^snacks_picker") then
          return true
        end
      end
      return false
    end

    local function feed(lhs)
      local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
      vim.api.nvim_feedkeys(keys, "m", false)
    end

    local function ensure_explorer()
      if explorer_is_open() then
        return
      end
      feed("<leader>e")
      vim.defer_fn(function()
        vim.cmd("wincmd l")
      end, 50)
    end

    vim.api.nvim_create_autocmd("DirChanged", {
      group = group,
      callback = function()
        vim.defer_fn(ensure_explorer, 150)
      end,
    })
  end,
}
