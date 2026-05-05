-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_inlay_hints = true

if vim.g.neovide then
  -- Font (required — terminal font doesn't carry over)
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"

  -- Animations
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_scroll_animation_length = 0.3

  -- Transparency (0.8 = 80% opaque)
  vim.g.neovide_opacity = 1.0

  -- Scale (useful for HiDPI/Retina)
  vim.g.neovide_scale_factor = 1.2

  -- Padding
  vim.g.neovide_padding_top = 8
  vim.g.neovide_padding_bottom = 8
  vim.g.neovide_padding_left = 8
  vim.g.neovide_padding_right = 8
end
