return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "scala" } },
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					metals = {},
				},
			},
		},
	}
end
