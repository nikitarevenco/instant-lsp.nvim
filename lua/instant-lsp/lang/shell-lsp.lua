return function(custom_opts)
	return {

		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"shfmt",
					"shellcheck",
				},
			},
		},
		{
			"stevearc/conform.nvim",
			ft = { "sh" },
			opts = {
				formatters_by_ft = {
					sh = { "shfmt" },
				},
			},
		},

		{
			"mfussenegger/nvim-lint",
			ft = { "sh" },
			opts = {
				linters_by_ft = {
					sh = { "shellcheck" },
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			ft = { "sh" },
			opts = {
				servers = {
					bashls = {},
				},
			},
		},
	}
end
