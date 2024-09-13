return function(custom_opts)
	return {
		{
			"Hoffs/omnisharp-extended-lsp.nvim",
			lazy = true,
		},

		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "c_sharp" } },
		},

		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					cs = { "csharpier" },
				},
				formatters = {
					csharpier = {
						command = "dotnet-csharpier",
						args = { "--write-stdout" },
					},
				},
			},
		},

		{
			"williamboman/mason.nvim",
			opts = { ensure_installed = { "csharpier", "netcoredbg" } },
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					omnisharp = {},
				},
			},
		},
	}
end
