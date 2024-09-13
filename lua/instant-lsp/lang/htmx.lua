return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "html" },
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					htmx = {
						filetypes = { "html", "templ" },
					},
					html = {
						filetypes = { "html", "templ" },
					},
				},
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					templ = { "templ" },
				},
			},
		},
	}
end
