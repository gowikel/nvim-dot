return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- The TypeScript extra disables ts_ls and runs vtsls, so settings
        -- belong here or they silently do nothing. The extra mirrors the
        -- typescript block onto javascript in its own setup.
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                variableTypes = { enabled = true },
                parameterNames = { enabled = "all" },
              },
            },
          },
        },
      },
    },
  },
}
