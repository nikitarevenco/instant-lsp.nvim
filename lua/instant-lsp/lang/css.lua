return function(custom_opts)
	return {
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"prettierd",
				},
			},
		},

		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"scss",
					"css",
					"styled",
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					cssls = {
						settings = {
							css = {
								validate = true,
								lint = {
									unknownAtRules = "ignore",
								},
							},
							scss = {
								validate = true,
								lint = {
									unknownAtRules = "ignore",
								},
							},
							less = {
								validate = true,
								lint = {
									unknownAtRules = "ignore",
								},
							},
						},
					},
				},
			},
		},

		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					css = { "prettierd" },
					less = { "prettierd" },
					scss = { "prettierd" },
				},
			},
		},
	}
end
