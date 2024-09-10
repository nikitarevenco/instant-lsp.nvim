return function(custom_opts)
	return {
		{
			"hrsh7th/nvim-cmp",
			dependencies = { "onsails/lspkind.nvim", { "roobert/tailwindcss-colorizer-cmp.nvim", config = true } },
			opts = {
				formatting = {
					format = function(entry, item)
						item = require("lspkind").cmp_format({
							maxwidth = 50,
							ellipsis_char = custom_opts.icons.ellipsis or "...",
						})(entry, item)
						return require("tailwindcss-colorizer-cmp").formatter(entry, item)
					end,
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"williamboman/mason-lspconfig.nvim",
					dependencies = {
						{
							"williamboman/mason.nvim",
						},
					},
					opts = function(_, opts)
						opts.ensure_installed = opts.ensure_installed or {}
						vim.list_extend(opts.ensure_installed, { "tailwindcss" })
					end,
				},
			},
		},
	}
end
