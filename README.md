# instant-lsp.nvim

> [!NOTE]
> This plugin is very new so currently has only a few languages, but I plan on adding more in the future

Provides a VSCode-like experience of installing new lsp servers. Fox example, with this config we will completely setup completion, snippets, lsp, keymappings:

```lua
require("instant-lsp").setup({ "lua", "typescript", "mdx", "tailwind" })
```

It's like a meta-plugin, one which configures plugins like `nvim-lspconfig` and `nvim-cmp` for you.
It returns a table of plugin specs for `lazy.nvim`

### Installation

```lua
local instant_lsp_path = vim.fn.stdpath("data") .. "/lazy/instant-lsp.nvim"
if not vim.loop.fs_stat(instant_lsp_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nikitarevenco/instant-lsp.nvim",
		instant_lsp_path,
	})
end
vim.opt.rtp:prepend(instant_lsp_path)
```

Then, along with your other plugins, add this:

```lua
local OPTIONS = { "lua" } -- see below for default config

local your_plugins = {
  -- your-other-plugin1 { ... },
  -- your-other-plugin2 { ... },
  require("instant-lsp").setup(OPTIONS),
  -- your-other-plugin4 { ... },
  -- your-other-plugin4 { ... }
}
```

And you are done!

Here is default config:

```lua
local default_options = {
	disable_feature = {
		snippets = false,
		virtual_text = false,
		cmp_border = false,
		ts_context = false,
		ts_autotag = false,
		autopairs = false,
	},
	misc = {
		format_on_save = false,
		completion_suggestions_count = 3,
	},
	keys = {
		typescript = {
			goto_source_definition = "gD",
			file_references = "gR",
			organize_imports = "<leader>co",
			add_missing_imports = "<leader>cM",
			remove_unused_imports = "<leader>cu",
			fix_all = "<leader>cD",
			select_ts_version = "<leader>cV",
		},
		cmp = {
			select_next_item = "<C-n>",
			select_prev_item = "<C-p>",
			scroll_docs_up = "<C-b>",
			scoll_docs_down = "<C-f>",
			confirm = "<tab>",
			abort = "<C-e>",
			goto_next_snippet_placeholder = "<C-l>",
			goto_prev_snippet_placeholder = "<C-h>",
		},
		lsp = {
			format = "<cr>",
			toggle_diagnostics = "<leader>ud",
			toggle_inlay_hints = "<leader>uh",
			goto_definition = "gd",
			goto_references = "gr",
			goto_implementation = "gI",
			goto_type_definition = "gt",
			code_rename = "<leader>cr",
			code_action = "<leader>ca",
			hover_documentation = "K",
			goto_declaration = "gD",
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
```
