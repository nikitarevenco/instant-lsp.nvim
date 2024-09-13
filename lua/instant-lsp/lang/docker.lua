return function(custom_opts)
	return {
		{
			"mfussenegger/nvim-lint",
			dependencies = {
				{
					"williamboman/mason.nvim",
					opts = { ensure_installed = { "hadolint" } },
				},
			},
			ft = { "dockerfile" },
			opts = {
				linters_by_ft = {
					dockerfile = { "hadolint" },
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			ft = {
				"dockerfile",
			},
			opts = {
				servers = {
					dockerls = {},
				},
			},
		},
	}
end
