return function(custom_opts)
  return {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = { "rust" },
      },
    },
    {
      "mfussenegger/nvim-lint",
      opts = {
        linters_by_ft = {
          rust = { "clippy" }
        }
      },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        {
          "Saecki/crates.nvim",
          tag = "stable",
          event = { "BufRead Cargo.toml" },
          opts = {},
        },
      },
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, { name = "crates" })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      ft = { "rust" },
      opts = {
        servers = {
          rust_analyzer = {},
        },
      },
    },
  }
end
