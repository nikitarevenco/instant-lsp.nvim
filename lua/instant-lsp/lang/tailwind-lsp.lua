return function(custom_opts)
	return {
		{
			"yioneko/nvim-cmp",
			dependencies = { "onsails/lspkind.nvim", { "roobert/tailwindcss-colorizer-cmp.nvim", config = true } },
			opts = {
				formatting = {
					format = function(entry, item)
						item = require("lspkind").cmp_format({
							maxwidth = 50,
							ellipsis_char = custom_opts.icons.ellipsis,
						})(entry, item)
						return require("tailwindcss-colorizer-cmp").formatter(entry, item)
					end,
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					tailwindcss = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			},
		},
	}
end
