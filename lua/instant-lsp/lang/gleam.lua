return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "gleam" } },
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					gleamls = {},
				},
			},
		},
	}
end
