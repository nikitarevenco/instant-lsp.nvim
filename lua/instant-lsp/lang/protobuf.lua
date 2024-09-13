return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"proto",
				},
			},
		},

		{
			"mason.nvim",
			opts = {
				ensure_installed = { "buf" },
			},
		},

		{
			"stevearc/conform.nvim",
			dependencies = { "mason.nvim" },
			opts = {
				formatters_by_ft = {
					proto = { "buf" },
				},
			},
		},

		{
			"mfussenegger/nvim-lint",
			dependencies = { "mason.nvim" },
			opts = {
				linters_by_ft = {
					proto = { "buf_lint" },
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					bufls = {},
				},
			},
		},
	}
end
