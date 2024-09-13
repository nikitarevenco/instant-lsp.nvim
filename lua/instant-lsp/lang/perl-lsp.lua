return function(custom_opts)
	return {
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"williamboman/mason.nvim",
					opts = function(_, opts)
						opts.ensure_installed = opts.ensure_installed or {}
						vim.list_extend(opts.ensure_installed, { "perlnavigator", "perl-debug-adapter" })
					end,
				},
			},
			opts = {
				setup = {
					perlnavigator = function()
						require("lspconfig").perlnavigator.setup({
							root_dir = require("lspconfig.util").root_pattern(".root", ".git"),
						})
						return true
					end,
				},
			},
		},
	}
end
