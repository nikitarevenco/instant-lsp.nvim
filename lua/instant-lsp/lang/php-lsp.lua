return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "php" } },
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					phpactor = {},
				},
			},
		},

		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"phpcs",
					"php-cs-fixer",
				},
			},
		},

		{
			"mfussenegger/nvim-lint",
			opts = {
				linters_by_ft = {
					php = { "phpcs" },
				},
			},
		},

		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					php = { "php_cs_fixer" },
				},
			},
		},
	}
end
