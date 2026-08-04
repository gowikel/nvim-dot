return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.lsp.progress = vim.tbl_deep_extend("force", opts.lsp.progress or {}, { enabled = false })
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
    end,
  },
}
