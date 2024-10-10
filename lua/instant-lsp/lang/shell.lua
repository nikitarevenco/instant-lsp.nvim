return function(custom_opts)
	return {

		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"shfmt",
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
