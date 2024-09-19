return function(custom_opts)
	return {
		{
			"stevearc/conform.nvim",
			ft = { "markdown" },
			opts = {
				formatters_by_ft = {
					markdown = { "prettierd" },
				},
			},
		},
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = { "prettierd" },
			},
		},
	}
end
