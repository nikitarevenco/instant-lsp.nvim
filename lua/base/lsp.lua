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

	function serializeTable(val, name, skipnewlines, depth)
		skipnewlines = skipnewlines or false
		depth = depth or 0

		local tmp = string.rep(" ", depth)

		if name then
			tmp = tmp .. name .. " = "
		end

		if type(val) == "table" then
			tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

			for k, v in pairs(val) do
				tmp = tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
			end

			tmp = tmp .. string.rep(" ", depth) .. "}"
		elseif type(val) == "number" then
			tmp = tmp .. tostring(val)
		elseif type(val) == "string" then
			tmp = tmp .. string.format("%q", val)
		elseif type(val) == "boolean" then
			tmp = tmp .. (val and "true" or "false")
		else
			tmp = tmp .. '"[inserializeable datatype:' .. type(val) .. ']"'
		end

		return tmp
	end
	return {
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			"hrsh7th/cmp-nvim-lsp",
		},
		config = function(a, b)
			-- print("1111111111111111")
			-- print("1111111111111111")
			-- print("1111111111111111")
			-- print("1111111111111111")
			-- print("1111111111111111")
			-- print("1111111111111111")
			-- print("1111111111111111")
			-- print(serializeTable(b.servers))
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

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("mason").setup()

      local servers = b.servers or {}

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
