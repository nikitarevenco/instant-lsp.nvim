return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			event = "VeryLazy",
			build = ":TSUpdate",
			opts = {
				auto_install = true,
				ensure_installed = { "diff", "regex", "markdown_inline", "http" },
				highlight = { enable = true },
				indent = { enable = true },
			},
			config = function(_, opts)
				local config = require("nvim-treesitter.configs")
				config.setup(opts)
			end,
		},
		custom_opts.disable_feature.ts_context and {} or {
			"nvim-treesitter/nvim-treesitter-context",
			dependencies = { "nvim-treesitter/nvim-treesitter", lazy = true },
		},
		custom_opts.disable_feature.ts_autotag and {} or {
			"windwp/nvim-ts-autotag",
			opts = {
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			},
		},
	}
end
