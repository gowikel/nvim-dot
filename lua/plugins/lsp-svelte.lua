return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("svelte.config.js", "svelte.config.mjs", "svelte.config.ts", "package.json")(fname)
              or util.find_git_ancestor(fname)
          end,
        },
      },
    },
  },
}
