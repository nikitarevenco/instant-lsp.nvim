return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"html",
					"css",
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					html = {
						filetypes = {
							"html",
							"javascript",
							"javascriptreact",
							"javascript.jsx",
							"typescript",
							"typescriptreact",
							"typescript.tsx",
						},
					},
					emmet_ls = {
						init_options = {
							html = {
								options = {
									["bem.enabled"] = true,
								},
							},
						},
					},
					cssls = {},
				},
			},
		},
	}
end
