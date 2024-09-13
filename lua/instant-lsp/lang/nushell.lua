return function(custom_opts)
	return {
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					nushell = {},
				},
			},
		},

		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				{ "nushell/tree-sitter-nu" },
			},
			opts = {
				ensure_installed = {
					"nu",
				},
			},
		},
	}
end
