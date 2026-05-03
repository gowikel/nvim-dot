return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      codelens = {
        enabled = true,
      },
      servers = {
        elixirls = {
          settings = {
            elixirLS = {
              enableTestLenses = true,
              suggestSpecs = true,
            },
          },
        },
      },
    },
  },
}
