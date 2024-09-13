return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "elm" } },
		},

		{
			"williamboman/mason.nvim",
			opts = { ensure_installed = { "elm-format" } },
		},

		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					elm = { "elm_format" },
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					elmls = {},
				},
			},
		},
	}
end
