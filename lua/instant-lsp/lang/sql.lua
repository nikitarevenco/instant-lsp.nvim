local sql_ft = { "sql", "mysql", "plsql" }

return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "sql" } },
		},
		{
			"williamboman/mason.nvim",
			opts = { ensure_installed = { "sqlfluff" } },
		},
		{
			"mfussenegger/nvim-lint",
			opts = function(_, opts)
				for _, ft in ipairs(sql_ft) do
					opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
					table.insert(opts.linters_by_ft[ft], "sqlfluff")
				end
			end,
		},
		{
			"stevearc/conform.nvim",
			opts = function(_, opts)
				opts.formatters.sqlfluff = {
					args = { "format", "--dialect=ansi", "-" },
				}
				for _, ft in ipairs(sql_ft) do
					opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
					table.insert(opts.formatters_by_ft[ft], "sqlfluff")
				end
			end,
		},
		{
			"kristijanhusak/vim-dadbod-completion",
			dependencies = "vim-dadbod",
			ft = sql_ft,
			init = function()
				vim.api.nvim_create_autocmd("FileType", {
					pattern = sql_ft,
					callback = function()
						local cmp = require("cmp")

						local sources = vim.tbl_map(function(source)
							return { name = source.name }
						end, cmp.get_config().sources)
						table.insert(sources, { name = "vim-dadbod-completion" })

						cmp.setup.buffer({ sources = sources })
					end,
				})
			end,
		},
	}
end
