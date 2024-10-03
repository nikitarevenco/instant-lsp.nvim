# instant-lsp.nvim

> [!NOTE]
> This plugin is in beta!

This is a meta-plugin which configures other plugins for you. With 1 line of code you can setup LSP for 49 available languages

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

  --[[ the above setup is a shorthand for:

  require("instant-lsp").setup({
    languages = {
      "html", "shell", "yaml", "htmx", "json", "csharp", "clojure",
      "powershell", "odin", "nim", "php", "thrift", "scala", "elm",
      "css", "c", "xml", "ansible", "go", "sql", "helm",
      "haskell", "dart", "tex", "astro", "angular", "svelte",
      "vue", "protobuf", "terraform", "python", "docker", "rust",
      "lua", "mdx", "tailwind", "typescript", "markdown", "cmake",
      "java", "verilog", "r", "perl", "csv", "ruby", "prisma",
      "plantuml", "nix", "git"
    }
  })

  -- your other plugins go here, e.g.
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
  ]]
}

-- your lazy.nvim setup stays the same
require("lazy").setup(your_plugins, --[[ lazy options ]])
```

Or just choose the ones that you want, and you are done!

**Note:** You'll likely need to install quite a few languages on your system if you choose the `all` options. e.g. you might need to install R, Rust, Ruby and others if you don't have them. If you don't want to do this, don't use `all` and just choose the languages you _do_ want!

Also, lets say you ask for 15 lsps out of the 49 available. Those 34 other files will just not be required at all, so this plugin won't unnecesserily download LSPs if you don't specify them.

### Configuration

The `setup` function accepts a table with the following default options:

```lua
local default_options = {
  languages = {},
	disable_feature = {
		snippets = false,
		virtual_text = false,
		cmp_border = false,
		ts_context = false,
		ts_autotag = false,
		autopairs = false,
		-- Will not use fzf-lua plugin for some LSP commands like "go to references"
		fzf_lua = false,
	},
	misc = {
		format_on_save = false,
		completion_suggestions_count = 3,
	},
	keys = {
		flutter = {
			start = "<leader>cs",
			devices = "<leader>ce",
			emulators = "<leader>ce",
			reload = "<leader>cl",
			restart = "<leader>cr",
			quit = "<leader>cq",
			detach = "<leader>cd",
			rename = "<leader>cr",
		},
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
			complete = "<C-Space>",
			goto_next_snippet_placeholder = "<C-l>",
			goto_prev_snippet_placeholder = "<C-h>",
		},
		lsp = {
			format = "<cr>",
			toggle_diagnostics = "<leader>ud",
			toggle_inlay_hints = "<leader>uh",
			signature_help = "<C-s>",
			goto_definition = "gd",
			code_rename = "grn",
			code_action = "gra",
			goto_implementation = "gI",
			goto_type_definition = "gt",
			hover_documentation = "K",
			hover_diagnostics = "<C-k>",
			goto_declaration = "gD",
			goto_prev_diagnostic = "[d",
			goto_next_diagnostic = "]d",
			-- these will use fzf-lua if enabled
			goto_references = "grr",
			document_symbols = "grd",
			workspace_symbols = "grs",
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

### How this is implemented

The plugin iterates through every string in the `languages` table that you pass to the setup function and looks for that file in `/lua/instant-lsp/lang/[lang].lua`

Each `[lang].lua` file (e.g. `lua.lua`, `css.lua`, `typescript.lua`) file will return a function, which gets called with your custom configuration as an argument, and returns the table of plugins, aka `LazySpec[]` that lazy.nvim accepts (Each plugin in `lazy.nvim` is considered a separate `LazySpec` type)

We then take all those `LazySpec[]` and combine them into a `LazySpec[][]` which is the table that this plugin returns, which goes directly into your lazy.nvim config.

The best part is the fact that `lazy.nvim` merges fields like `opts` in each of the plugins. This means I can call the `lspconfig` plugin in all 49 files, and provide the configs for the language servers separately

Lazy.nvim will then merge all these `opts` into a single giant `opts` object, which means its also super easy to extend functionality of this plugin with your own additions (although PRs are super welcome!)