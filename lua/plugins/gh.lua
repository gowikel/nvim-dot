return {
  {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup({
        panel = {
          orientation = "left",
          panel_size = 40,
        },
      })
    end,
  },
}
