return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      opts.cmd = {
        vim.fn.exepath("jdtls"),
        "--java-executable",
        vim.fn.expand("~/.sdkman/candidates/java/current/bin/java"),
      }
      return opts
    end,
  },
}
