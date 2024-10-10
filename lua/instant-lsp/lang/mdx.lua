return function(custom_opts)
	return {
		{
			"davidmh/mdx.nvim",
			config = true,
			dependencies = { "nvim-treesitter/nvim-treesitter" },
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					mdx = { "prettierd" },
				},
			},
		},
	}
end
