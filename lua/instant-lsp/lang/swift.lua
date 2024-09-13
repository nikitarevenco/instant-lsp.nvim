return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"objc",
					"swift",
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					sourcekit = {},
				},
				settings = {
					sourcekit = {
						filetypes = { "swift", "objective-c", "objective-cpp" },
					},
				},
			},
		},
	}
end
