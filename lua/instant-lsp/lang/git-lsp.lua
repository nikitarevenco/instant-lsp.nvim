return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "git_config", "gitcommit", "git_rebase", "gitignore", "gitattributes" } },
		},
		{
			"nvim-cmp",
			dependencies = {
				{ "petertriho/cmp-git", opts = {} },
			},
			opts = function(_, opts)
				table.insert(opts.sources, { name = "git" })
			end,
		},
	}
end
