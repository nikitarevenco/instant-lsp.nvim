return function(custom_opts)
	return {
		{
			"nvim-treesitter",
			opts = { ensure_installed = { "thrift" } },
		},

		{
			"nvim-lspconfig",
			opts = {
				servers = {
					thriftls = {},
				},
			},
		},
	}
end
