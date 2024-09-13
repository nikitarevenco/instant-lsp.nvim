return function(custom_opts)
	return {
		{
			"hrsh7th/nvim-cmp",
			optional = true,
			dependencies = { "R-nvim/cmp-r" },
			opts = function(_, opts)
				opts.sources = opts.sources or {}
				table.insert(opts.sources, { name = "cmp_r" })
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "r", "rnoweb" } },
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					r_language_server = {},
				},
			},
		},
	}
end
