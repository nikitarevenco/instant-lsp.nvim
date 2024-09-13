return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "prisma" },
			},
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					prismals = {},
				},
			},
		},
	}
end
