return function(opts)
	return {
		{
			-- https://github.com/stevearc/conform.nvim
			"stevearc/conform.nvim",
			event = "BufWritePre",
			config = function(_, opts)
				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = "*",
					callback = function(args)
						if vim.g.auto_format then
							require("conform").format({
								bufnr = args.buf,
								timeout_ms = 5000,
								lsp_format = "fallback",
							})
						else
						end
					end,
				})

				vim.g.auto_format = opts.misc.format_on_save or false

				require("conform").setup(opts)
			end,
		},
	}
end
