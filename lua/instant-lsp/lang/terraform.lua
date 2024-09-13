return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "terraform", "hcl" } },
		},
		{
			"williamboman/mason.nvim",
			opts = { ensure_installed = { "tflint" } },
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					terraform = { "terraform_fmt" },
					tf = { "terraform_fmt" },
					["terraform-vars"] = { "terraform_fmt" },
				},
			},
		},

		{
			"mfussenegger/nvim-lint",
			opts = {
				linters_by_ft = {
					terraform = { "terraform_validate" },
					tf = { "terraform_validate" },
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					terraformls = {},
				},
			},
		},
	}
end
