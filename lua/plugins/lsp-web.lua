return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- LazyVim has no html/css extra, so nothing enabled these
        html = {},
        cssls = {},
        emmet_language_server = {
          filetypes = {
            "css",
            "eruby",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "css-lsp", "emmet-language-server", "html-lsp" } },
  },
}
