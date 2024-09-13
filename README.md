# instant-lsp.nvim

This is a meta-plugin which configures other plugins for you. With 1 line of code you can setup LSP for 52 available languages
You can choose which languages to include rather than everything!

### Installation

```lua
local instant_lsp_path = vim.fn.stdpath("data") .. "/instant-lsp.nvim"

-- Clone the plugin onto your system
if not vim.loop.fs_stat(instant_lsp_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nikitarevenco/instant-lsp.nvim",
		instant_lsp_path,
	})
end

-- Let neovim recognize the plugin's path so we can require it
vim.opt.rtp:prepend(instant_lsp_path)
```

Then, along with your other plugins, add this to setup every language:

```lua

local your_plugins = {
  require("instant-lsp").setup({ languages = "all" }),
  -- the above setup is a shorthand for:
  -- require("instant-lsp").setup({languages = { "html", "shell", "yaml", "htmx", "json", "csharp", "clojure", "powershell", "odin", "nim", "php", "thrift", "scala", "elm", "css", "c", "swift", "xml", "ansible", "go", "sql", "helm", "haskell", "gleam", "dart", "tex", "astro", "angular", "svelte", "vue", "protobuf", "terraform", "python", "docker", "rust", "lua", "mdx", "tailwind", "typescript", "markdown", "cmake", "java", "verilog", "r", "perl", "csv", "ruby", "prisma", "plantuml", "nushell", "nix", "git" }})

  -- your other plugins go here, e.g.
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}

-- your lazy.nvim setup stays the same
require("lazy").setup(your_plugins, --[[ lazy options ]])
```

Or just choose the ones that you want, and you are done!

The `setup` function accepts a table with the following default options:

```lua
local default_options = {
  languages = {}, -- see above on how to add languages
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
