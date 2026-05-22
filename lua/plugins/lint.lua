return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = {
        args = { "--config", vim.fn.stdpath("config") .. "/markdownlint-cli2.yaml", "--" },
      }
      return opts
    end,
  },
}
