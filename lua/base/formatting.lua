return function(custom_opts)
	return {
		{
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

				vim.keymap.set("n", custom_opts.keys.lsp.format or "<cr>", function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end, { desc = "format" })

				vim.g.auto_format = custom_opts.misc.format_on_save or false

				require("conform").setup(opts)
			end,
		},
	}
end
