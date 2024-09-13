return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "astro" } },
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					astro = {},
				},
			},
		},

		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					astro = { "prettier" },
				},
			},
		},
	}
end
