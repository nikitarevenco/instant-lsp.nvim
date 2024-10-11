local M = {}

local default_options = {
	disable_feature = {
		snippets = false,
		virtual_text = false,
		cmp_border = false,
		ts_context = false,
		ts_autotag = false,
		autopairs = false,
		-- When set to `false`, it will use fzf-lua plugin for some LSP commands like "find references" or "find symbols"
		fzf_lua = false,
	},
	misc = {
		format_on_save = false,
		completion_suggestions_count = 5,
	},
	keys = {
		flutter = {
			start = "<leader>fs",
			devices = "<leader>fd",
			emulators = "<leader>fe",
			reload = "<leader>fl",
			restart = "<leader>fr",
			quit = "<leader>fq",
			detach = "<leader>fx",
			rename = "<leader>fn",
		},
		typescript = {
			-- override lsp.goto_declaration, since that option is not available in typescript
			goto_source_definition = "gD",
			file_references = "<leader>tr",
			organize_imports = "<leader>to",
			add_missing_imports = "<leader>ta",
			remove_unused_imports = "<leader>ti",
			fix_all = "<leader>tf",
			select_ts_version = "<leader>ts",
		},
		cmp = {
			scroll_docs_up = "<C-k>",
			scoll_docs_down = "<C-j>",
			confirm = "<cr>",
			select_next_item = "<tab>",
			select_prev_item = "<s-tab>",
			abort = "<C-e>",
			complete = "<C-Space>",
			goto_next_snippet_placeholder = "<C-l>",
			goto_prev_snippet_placeholder = "<C-h>",
		},
		-- default: default keybinding as set by neovim in https://github.com/neovim/neovim/blob/master/runtime/lua/vim/_defaults.lua
		-- fzf-lua: will use fzf-lua if that feature is not disabled in "disable_feature"
		lsp = {
			signature_help = "<C-s>", -- default
			goto_definition = "gd",
			goto_implementation = "gI",
			goto_type_definition = "gt",
			hover_documentation = "K",
			hover_diagnostics = "<c-w><c-d>", -- default
			goto_declaration = "gD",
			goto_prev_diagnostic = "[d", -- default
			goto_next_diagnostic = "]d", -- default
			goto_first_diagnostic = "[D", -- default
			goto_last_diagnostic = "]D", -- default
			format = "<cr>",
			toggle_diagnostics = "<leader>ld",
			toggle_inlay_hints = "<leader>lh",
			code_rename = "grn", -- default
			code_action = "gra", -- default
			goto_references = "grr", -- default fzf-lua
			document_symbols = "<leader>ld", -- fzf-lua
			workspace_symbols = "<leader>lw", -- fzf-lua
		},
	},
	icons = {
		ellipsis = "...",
		vtext_prefix = "●",
		error = " ",
		warn = " ",
		hint = " ",
		info = " ",
	},
}

local languages = {
	"html",
	"shell",
	"yaml",
	"htmx",
	"json",
	"csharp",
	"clojure",
	"powershell",
	"odin",
	"nim",
	"php",
	"thrift",
	"scala",
	"elm",
	"css",
	"c",
	"xml",
	"ansible",
	"go",
	"sql",
	"helm",
	"haskell",
	"dart",
	"tex",
	"astro",
	"angular",
	"svelte",
	"vue",
	"protobuf",
	"terraform",
	"python",
	"docker",
	"rust",
	"lua",
	"mdx",
	"tailwind",
	"typescript",
	"markdown",
	"cmake",
	"java",
	"verilog",
	"r",
	"perl",
	"csv",
	"ruby",
	"prisma",
	"plantuml",
	"nix",
	"git",
}

local function setmetatable_recursive(tbl, default)
	local mt = { __index = default }
	setmetatable(tbl, mt)
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			setmetatable_recursive(v, default[k] or default)
		end
	end
end

function M.setup(custom_opts)
	default_options.__index = default_options
	setmetatable_recursive(custom_opts, default_options)

	local specs = {
		require("instant-lsp.base.lsp")(custom_opts),
		require("instant-lsp.base.cmp")(custom_opts),
		require("instant-lsp.base.treesitter")(custom_opts),
		require("instant-lsp.base.formatting")(custom_opts),
		require("instant-lsp.base.linting")(custom_opts),
		require("instant-lsp.base.fzf")(custom_opts),
	}

	for _, lang in ipairs(custom_opts.languages == "all" and languages or custom_opts.languages) do
		table.insert(specs, require("instant-lsp.lang." .. lang)(custom_opts))
	end

	return specs
end

return M
