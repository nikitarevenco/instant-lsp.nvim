local filetypes = { "json", "jsonc", "json5" }

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
	pattern = filetypes,
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

return function(custom_opts)
	return {

		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = "biome",
			},
		},
		{
			"stevearc/conform.nvim",
			dependencies = {},
			ft = filetypes,
			opts = {
				formatters_by_ft = {
					json = { "biome" },
					jsonc = { "biome" },
					json5 = { "biome" },
				},
				formatters = {
					biome = {
						args = { "format", "--indent-style", "space", "--stdin-file-path", "$FILENAME" },
					},
				},
			},
		},

		{
			"neovim/nvim-lspconfig",
			ft = filetypes,
			opts = {
				servers = {
					jsonls = {},
				},
			},
		},
	}
end
