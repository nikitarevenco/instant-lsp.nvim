return function(custom_opts)
	return {
		{
			"williamboman/mason.nvim",
			opts = { ensure_installed = { "goimports", "gofumpt" } },
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					go = { "goimports", "gofumpt" },
				},
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "go", "gomod", "gowork", "gosum" },
			},
		},
		{
			"neovim/nvim-lspconfig",
			ft = { "go" },
			opts = {
				servers = {
					gopls = {
						settings = {
							gopls = {
								analyses = {
									unusedvariable = true,
									unusedwrite = true,
									useany = true,
									fieldalignment = true,
								},
								gofumpt = true,
								hoverKind = "SynopsisDocumentation",
								codelenses = {
									gc_details = false,
									generate = true,
									regenerate_cgo = true,
									run_govulncheck = true,
									test = true,
									tidy = true,
									upgrade_dependency = true,
									vendor = true,
								},
								hints = {
									parameterNames = true,
								},
								completeUnimported = true,
								semanticTokens = true,
							},
						},
					},
				},
			},
		},
	}
end
