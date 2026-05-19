return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = true, replace_netrw = true },
    picker = {
      sources = {
        explorer = {
          auto_close = false,
          hidden = true,
        },
      },
    },
  },
  init = function()
    local group = vim.api.nvim_create_augroup("snacks_explorer_autoopen", { clear = true })

    local function explorer_is_open()
      return #Snacks.picker.get({ source = "explorer" }) > 0
    end

    local function open_unfocused()
      if not explorer_is_open() then
        Snacks.explorer.open({ focus = false })
      end
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      group = group,
      callback = function()
        vim.schedule(open_unfocused)
      end,
    })

    vim.api.nvim_create_autocmd("DirChanged", {
      group = group,
      callback = function()
        for _, p in ipairs(Snacks.picker.get({ source = "explorer" })) do
          p:close()
        end
        Snacks.explorer.open({ focus = false, cwd = vim.fn.getcwd() })
      end,
    })
  end,
}
