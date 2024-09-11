return function(custom_opts)
	return {
		{
			"williamboman/mason.nvim",
			opts = {
				ensure_installed = {
					"black",
				},
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "ninja", "python", "rst" } },
		},
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					basedpyright = {
						enabled = true,
						settings = {
							basedpyright = {
								analysis = {
									autoImportCompletions = true,
									autoSearchPaths = true,
									diagnosticMode = "workspace",
									diagnosticSeverityOverrides = {
										reportArgumentType = "none",
										reportAttributeAccessIssue = "none",
										reportCallIssue = "none",
										reportFunctionMemberAccess = "none",
										reportGeneralTypeIssues = "none",
										reportIncompatibleMethodOverride = "none",
										reportIncompatibleVariableOverride = "none",
										reportIndexIssue = "none",
										reportOptionalMemberAccess = "none",
										reportOptionalSubscript = "none",
										reportPrivateImportUsage = "none",
									},
									indexing = true,
									inlayHints = {
										functionReturnTypes = true,
										variableTypes = true,
									},
									typeCheckingMode = "off", -- Pyright diagnostics is bloody slow
									useLibraryCodeForTypes = true,
								},
							},
						},
						root_dir = {
							"pyproject.toml",
							"setup.py",
							"setup.cfg",
							"requirements.txt",
							"Pipfile",
							"pyrightconfig.json",
						},
					},
					ruff_lsp = {
						keys = {
							{
								custom_opts.keys.typescript.organize_imports or "<leader>co",
								function()
									vim.lsp.buf.code_action({
										apply = true,
										context = {
											only = { "source.organizeImports" },
											diagnostics = {},
										},
									})
								end,
								desc = "Organize Imports",
							},
						},
						on_attach = function(client, _)
							client.server_capabilities.hoverProvider = true
						end,
					},
				},
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					python = { "black" },
				},
			},
		},
	}
end
