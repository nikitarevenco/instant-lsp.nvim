vim.filetype.add({
	pattern = {
		[".*/%.github/dependabot.yml"] = "dependabot",
		[".*/%.github/dependabot.yaml"] = "dependabot",
		[".*/%.github/workflows[%w/]+.*%.yml"] = "gha",
		[".*/%.github/workflows/[%w/]+.*%.yaml"] = "gha",
	},
})

vim.treesitter.language.register("yaml", "gha")
vim.treesitter.language.register("yaml", "dependabot")

return function(custom_opts)
	return {

		{
			"williamboman/mason.nvim",
			opts = { ensure_installed = { "yamlfmt", "actionlint" } },
		},
		{
			"stevearc/conform.nvim",
			ft = { "yaml", "gha", "dependabot" },
			opts = {
				formatters_by_ft = {
					yaml = { "yamlfmt" },
					gha = { "yamlfmt" },
					dependabot = { "yamlfmt" },
				},
			},
		},

		{
			"mfussenegger/nvim-lint",
			ft = { "gha" },
			opts = {
				linters_by_ft = {
					gha = { "actionlint" },
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			ft = { "yaml", "gha", "dependabot" },
			opts = {
				servers = {
					yamlls = {
						filetypes = { "yaml", "gha", "dependabot" },
					},
				},
			},
		},
	}
end
