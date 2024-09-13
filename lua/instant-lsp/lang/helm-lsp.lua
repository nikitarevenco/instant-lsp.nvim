return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "helm" } },
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					helm_ls = {},
				},
			},
		},
	}
end
