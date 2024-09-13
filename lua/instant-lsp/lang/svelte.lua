return function(custom_opts)
	return {
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					svelte = {},
				},
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "svelte" },
			},
		},
	}
end
