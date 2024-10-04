return function(custom_opts)
	return {
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = "vue-language-server",
			},
		},

		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "vue", "css", "scss", "html", "json" } },
		},

		{
			"nvim-lspconfig",
			opts = {
				servers = {
					volar = {
						filetypes = {
							"vue",
							"javascript",
							"javascript.jsx",
							"typescript",
							"typescript.tsx",
							"javascriptreact",
							"typescriptreact",
							"json",
						},
					},
				},
			},
		},
	}
end
