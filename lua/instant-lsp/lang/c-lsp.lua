return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "c", "cpp" } },
		},
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"clang-format",
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					clangd = {},
				},
			},
		},
		{
			"stevearc/conform.nvim",
			optional = true,
			opts = {
				formatters_by_ft = {
					c = { "clang-format" },
					cpp = { "clang-format" },
				},
			},
		},
	}
end
