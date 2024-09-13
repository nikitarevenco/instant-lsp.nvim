return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"xml",
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					lemminx = {},
				},
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					xml = { "prettierd" },
				},
			},
		},
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"lemminx",
				},
			},
		},
	}
end
