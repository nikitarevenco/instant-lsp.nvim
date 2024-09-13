-- Fix conceallevel for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("markdown_conceal", { clear = true }),
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})

return function(custom_opts)
	return {

		{
			"stevearc/conform.nvim",
			ft = { "markdown" },
			opts = {
				formatters_by_ft = {
					markdown = { "prettier" },
				},
			},
		},

		{
			"mfussenegger/nvim-lint",
			dependencies = {
				{
					"williamboman/mason.nvim",
					opts = {
						ensure_installed = { "markdownlint", "markdowntoc" },
					},
				},
			},
			ft = { "markdown" },
			opts = {
				linters_by_ft = {
					markdown = { "markdownlint", "markdown-toc" },
				},
			},
		},
	}
end
