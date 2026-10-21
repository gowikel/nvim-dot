-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- The GitHub preview replaces the picker's preview buffer, so the picker's own
-- keymaps are lost in it. Restore the window cycle for that buffer.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown.gh",
  callback = function(event)
    vim.keymap.set("n", "<a-w>", function()
      local win = vim.api.nvim_get_current_win()
      for _, picker in ipairs(Snacks.picker.get()) do
        if picker.preview and picker.preview.win and picker.preview.win.win == win then
          return require("snacks.picker.actions").cycle_win(picker)
        end
      end
    end, { buffer = event.buf, desc = "Cycle picker window" })
  end,
})
