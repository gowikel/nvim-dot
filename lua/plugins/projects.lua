return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          projects = {
            dev = { "~/Code/cvf", "~/Code/personal" },
            filter = {
              paths = { ["~/.gemini"] = false },
            },
            max_depth = 5,
            patterns = {
              ".git",
              "_darcs",
              ".hg",
              ".bzr",
              ".svn",
              "package.json",
              "Makefile",
              "build.gradle",
              "settings.gradle",
              "pom.xml",
              "uv.lock",
              "mix.exs",
            },
          },
        },
      },
    },
  },
}
