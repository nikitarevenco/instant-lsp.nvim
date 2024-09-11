return function(custom_opts)
	return {
		{
			"mfussenegger/nvim-lint",
			opts = {
				linters = {
					luacheck = {
						condition = function(ctx)
							return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
						end,
					},
				},
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "lua" },
			},
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					"stylua",
					"luacheck",
				},
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"folke/lazydev.nvim",
					ft = "lua",
					opts = {
						library = {
							{ path = "luvit-meta/library", words = { "vim" } },
						},
					},
				},
				{ "Bilal2453/luvit-meta", lazy = true },
			},
			ft = { "lua" },
			opts = {
				servers = {
					["lua_ls"] = {
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								workspace = {
									checkThirdParty = false,
								},
								codeLens = {
									enable = true,
								},
								completion = {
									callSnippet = "Replace",
								},
								doc = {
									privateName = { "^_" },
								},
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
								},
							},
						},
					},
				},
			},
		},
	}
end
