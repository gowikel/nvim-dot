return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {
          root_dir = function(bufnr, on_dir)
            local fname = type(bufnr) == "number" and vim.api.nvim_buf_get_name(bufnr) or bufnr
            local util = require("lspconfig.util")
            local root = util.root_pattern("svelte.config.js", "svelte.config.mjs", "svelte.config.ts", "package.json")(fname)
              or vim.fs.root(fname, { ".git" })
            if type(on_dir) == "function" then
              on_dir(root)
            else
              return root
            end
          end,
        },
      },
    },
  },
}
