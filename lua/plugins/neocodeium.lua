return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      require("neocodeium").setup()
      local nc = require("neocodeium")
      local blink = require("blink.cmp")
      vim.keymap.set("i", "<M-f>", function() blink.hide(); nc.accept() end)
      vim.keymap.set("i", "<M-w>", function() blink.hide(); nc.accept_word() end)
      vim.keymap.set("i", "<M-l>", function() blink.hide(); nc.accept_line() end)
      vim.keymap.set("i", "<M-j>", function() blink.hide(); nc.cycle_or_complete() end)
      vim.keymap.set("i", "<M-k>", function() blink.hide(); nc.cycle_or_complete(-1) end)
      vim.keymap.set("i", "<M-c>", function() nc.clear() end)
    end,
  },
}
