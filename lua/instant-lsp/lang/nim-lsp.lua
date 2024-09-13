return function(custom_opts)
	return {
		{
			"neovim/nvim-lspconfig",
			ft = { "nim" },
			opts = {
				servers = {
					nim_langserver = {},
				},
			},
		},
		{
			"alaviss/nim.nvim",
			ft = { "nim" },
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"nim",
					"nim-format-string",
				},
			},
		},
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"nimpretty",
				},
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					["nim"] = { "nimpretty" },
				},
			},
		},
	}
end
