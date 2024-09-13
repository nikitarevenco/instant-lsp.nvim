return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "ninja", "rst" } },
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = { pyright = {} },
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = { python = { "black" } },
			},
		},
	}
end
