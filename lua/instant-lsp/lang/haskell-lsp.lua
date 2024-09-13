return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "haskell" } },
		},

		{
			"mrcjkb/haskell-tools.nvim",
			version = "^4",
		},

		{
			"mrcjkb/haskell-snippets.nvim",
			dependencies = { "L3MON4D3/LuaSnip" },
			ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
			config = function()
				local haskell_snippets = require("haskell-snippets").all
				require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
			end,
		},

		{
			"neovim/nvim-lspconfig",
			opts = {
				setup = {
					hls = function()
						return true
					end,
				},
			},
		},
	}
end
