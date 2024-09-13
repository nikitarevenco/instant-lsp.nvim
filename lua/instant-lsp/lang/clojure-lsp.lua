return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"clojure",
				},
			},
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"PaterJason/cmp-conjure",
			},
			opts = function(_, opts)
				if type(opts.sources) == "table" then
					vim.list_extend(opts.sources, { name = "clojure" })
				end
			end,
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					["clojure-lsp"] = {},
				},
			},
		},
	}
end
