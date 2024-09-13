return function(custom_opts)
	return {

		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = { "djlint" },
			},
		},

		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "angular" },
			},
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					angularls = {},
				},
			},
		},

		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"johnpapa/vscode-angular-snippets",
			},
		},
	}
end
