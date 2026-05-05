-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>l") -- LazyVim
vim.keymap.del("n", "<leader>L") -- LazyVim changelog
vim.keymap.del("n", "<leader>K") -- Keywordprg
vim.keymap.del("n", "<leader>S") -- Select scratch buffer
vim.keymap.del("n", "<leader>?") -- Buffer keymaps (which-key)
vim.keymap.del("n", "<leader>`") -- Switch to other buffer

vim.keymap.set("t", "<D-\\><D-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<D-/><D-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "<D-v>", "<C-r>+", { desc = "Paste from clipboard" })
vim.keymap.set("t", "<D-v>", '<C-\\><C-n>"+pi', { desc = "Paste from clipboard" })
