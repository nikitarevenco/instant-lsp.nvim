local function setup_lsp_keymaps(opts, event)
	vim.keymap.set("n", opts.keys.lsp.toggle_diagnostics or "<leader>ud", function()
		vim.diagnostic.enable(not vim.diagnostic.is_enabled())
	end, { desc = "toggle diagnostics", noremap = false, silent = true })

	vim.keymap.set("n", opts.keys.lsp.toggle_inlay_hints or "<leader>uh", function()
		local filter = {}
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter))
	end, { desc = "Toggle inlay hints", noremap = false, silent = true })

	vim.keymap.set(
		"n",
		opts.keys.lsp.goto_definition or "gd",
		vim.lsp.buf.definition,
		{ buffer = event.buf, desc = "LSP: Goto Definition", nowait = true }
	)

	vim.keymap.set(
		"n",
		opts.keys.lsp.goto_references or "gr",
		vim.lsp.buf.references,
		{ buffer = event.buf, desc = "LSP: Goto References", nowait = true }
	)

	vim.keymap.set(
		"n",
		opts.keys.lsp.goto_implementation or "gI",
		vim.lsp.buf.implementation,
		{ buffer = event.buf, desc = "LSP: Goto Implementation", nowait = true }
	)

	vim.keymap.set(
		"n",
		opts.keys.lsp.goto_type_definition or "gt",
		vim.lsp.buf.type_definition,
		{ buffer = event.buf, desc = "LSP: Goto Type Definition", nowait = true }
	)

	vim.keymap.set(
		"n",
		opts.keys.lsp.code_rename or "<leader>cr",
		vim.lsp.buf.rename,
		{ buffer = event.buf, desc = "LSP: Code Rename", nowait = true }
	)

	vim.keymap.set(
		"n",
		opts.keys.lsp.code_action or "<leader>ca",
		vim.lsp.buf.code_action,
		{ buffer = event.buf, desc = "LSP: Code Action", nowait = true }
	)

	vim.keymap.set(
		"n",
		opts.keys.lsp.hover_documentation or "K",
		vim.lsp.buf.hover,
		{ buffer = event.buf, desc = "LSP: Hover Documentation", nowait = true }
	)

	vim.keymap.set(
		"n",
		opts.keys.lsp.goto_declaration or "gD",
		vim.lsp.buf.declaration,
		{ buffer = event.buf, desc = "LSP: Goto Declaration", nowait = true }
	)
end

return function(custom_opts)
	local diagnostics_icons = {
		Error = custom_opts.icons.error or " ",
		Warn = custom_opts.icons.warn or " ",
		Hint = custom_opts.icons.hint or " ",
		Info = custom_opts.icons.info or " ",
	}

	return {
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			diagnostics = {
				underline = false,
				update_in_insert = false,
				virtual_text = {
					prefix = custom_opts.icons.vtext_prefix or "●",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = diagnostics_icons.Error,
						[vim.diagnostic.severity.WARN] = diagnostics_icons.Warn,
						[vim.diagnostic.severity.HINT] = diagnostics_icons.Hint,
						[vim.diagnostic.severity.INFO] = diagnostics_icons.Info,
					},
				},
			},
		},
		config = function(_, opts)
			vim.diagnostic.config({ virtual_text = not custom_opts.disable_feature.virtual_text })
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					setup_lsp_keymaps(custom_opts, event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			for type, icon in pairs(diagnostics_icons) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("mason").setup()

			local servers = opts.servers or {}

			local ensure_installed = vim.tbl_keys(servers)

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	}
end
