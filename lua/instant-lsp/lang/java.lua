return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "java" } },
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					jdtls = {},
				},
			},
		},
	}
end
