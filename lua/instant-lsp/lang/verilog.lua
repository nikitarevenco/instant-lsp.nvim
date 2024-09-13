return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = {
					"verilog",
				},
			},
		},
		{
			"stevearc/conform.nvim",
			optional = true,
			opts = {
				formatters_by_ft = { verilog = { "verible" } },
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					verible = {
						cmd = {
							"verible-verilog-ls",
						},
					},
				},
			},
		},
	}
end
