return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "javascript", "typescript", "tsx" },
			},
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{
					"Saecki/crates.nvim",
					tag = "stable",
					event = { "BufRead Cargo.toml" },
					opts = {},
				},
			},
			opts = function(_, opts)
				opts.sources = opts.sources or {}
				table.insert(opts.sources, { name = "crates" })
			end,
		},
		{
			"mrcjkb/rustaceanvim",
			version = "^4",
			ft = { "rust" },
			opts = {
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { desc = "Code Action", buffer = bufnr })
						vim.keymap.set("n", "<leader>dr", function()
							vim.cmd.RustLsp("debuggables")
						end, { desc = "Rust Debuggables", buffer = bufnr })
					end,
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								runBuildScripts = true,
							},
							checkOnSave = true,
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
			},
			config = function(_, opts)
				vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
			end,
		},
	}
end
