return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Default filetypes are copied from tailwindcss-intellisense (43 of
        -- them, including markdown and typescriptreact), which makes this
        -- server attach all over the place and log errors. Narrow it to the
        -- HTML-ish filetypes where htmx attributes actually appear.
        htmx = {
          filetypes = { "html", "htmldjango", "htmx" },
        },
      },
    },
  },
}
