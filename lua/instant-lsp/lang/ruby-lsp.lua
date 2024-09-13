return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "ruby" } },
		},

		{
			"neovim/nvim-lspconfig",
			optional = true,
			opts = {
				servers = {
					solargraph = {},
				},
			},
		},
	}
end
