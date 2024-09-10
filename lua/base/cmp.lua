return function(custom_opts)
	return {
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{
					"hrsh7th/cmp-nvim-lsp",
					dependencies = {
						{
							"L3MON4D3/LuaSnip",
							dependencies = {
								"saadparwaiz1/cmp_luasnip",
								"rafamadriz/friendly-snippets",
							},
							-- keys = require("config.keymaps").setup_snippets_keymaps(),
						},
					},
				},
				{ "hrsh7th/cmp-cmdline" },
			},
			opts = function(_, opts)
				local cmp = require("cmp")
				require("luasnip.loaders.from_vscode").lazy_load()

				local sources = opts.sources or {}
				vim.list_extend(sources, {
					{
						name = "nvim_lsp",
						entry_filter = function(entry)
							-- this will stop the snippet suggestions in jsx to make everything a component, for example you type "useSta" and the first suggestion would be <useSta></useSta>
							return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
						end,
					},
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "buffer" },
				})

				-- `/` cmdline setup.
				cmp.setup.cmdline({ "/", "?" }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = "buffer" },
					},
				})

				-- `:` cmdline setup.
				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "path" },
					}, {
						{
							name = "cmdline",
							option = {
								ignore_cmds = { "Man", "!" },
							},
						},
					}),
				})

				return {
					performance = {
						max_view_entries = custom_opts.misc.completion_suggestions_count or 3,
					},
					completion = {
						completeopt = "menu,menuone,preview,noselect",
					},
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
						[custom_opts.keys.cmp.abort or "<C-e>"] = cmp.mapping.abort(),
						[custom_opts.keys.cmp.confirm or "<tab>"] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources(sources),
				}
			end,
		},
	}
end
