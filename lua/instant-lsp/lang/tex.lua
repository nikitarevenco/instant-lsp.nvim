return function(custom_opts)
	return {

		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"latex",
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			optional = true,
			opts = {
				servers = {
					texlab = {},
				},
			},
		},
	}
end
