return function(custom_opts)
	return {
		{
			"davidmh/mdx.nvim",
			config = true,
			dependencies = { "nvim-treesitter/nvim-treesitter" },
		},
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				ensure_installed = {
					"mdx_analyzer",
				},
			},
		},
	}
end
