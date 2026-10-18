return {
  {
    "cursortab/cursortab.nvim",
    lazy = false,
    build = "cd server && go build",
    config = function()
      -- Hand <Tab> back to blink.cmp's existing chain: snippet jump, then
      -- cursortab accept, then the key's original behaviour (indent).
      LazyVim.cmp.actions.ai_accept = function()
        local ok, cursortab = pcall(require, "cursortab")
        if ok and cursortab.accept() then
          return true
        end
      end

      require("cursortab").setup({
        provider = {
          type = "zeta-2.1",
          url = "http://127.0.0.1:8000",
          model = "zeta2.1",
          context_size = 8192,
          max_tokens = 256,
          completion_timeout = 12000,
          max_diff_history_tokens = 256,
        },
        keymaps = { accept = false },
        behavior = {
          text_change_debounce = 200,
          idle_completion_delay = 300,
          enabled_modes = { "insert" },
        },
      })
    end,
  },
}
