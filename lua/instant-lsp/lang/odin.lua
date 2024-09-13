return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"odin",
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					ols = {},
				},
			},
		},
	}
end
