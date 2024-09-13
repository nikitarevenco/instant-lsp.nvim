return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"cmake",
				},
			},
		},
		{
			"Civitasv/cmake-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			event = "BufRead",
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					neocmake = {},
				},
				settings = {
					neocmake = {},
				},
			},
		},
	}
end
