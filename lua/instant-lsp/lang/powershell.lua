return function(custom_opts)
	return {
		{
			"sakakibara/vim-ps1",
			ft = "ps1",
		},

		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"powershell-editor-services",
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					powershell_es = {
						bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
					},
				},
			},
		},
	}
end
