return function(custom_opts)
  return {
    custom_opts.disable_feature.autopairs or {} and {
      "windwp/nvim-autopairs",
      event = { "InsertEnter" },
      dependencies = {
        "hrsh7th/nvim-cmp",
      },
      opts = {
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      },
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)

        local Rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")

        npairs.add_rule(Rule("*", "*", "markdown"))

        require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        {
          "hrsh7th/cmp-nvim-lsp",
          dependencies = {
            {
              "L3MON4D3/LuaSnip",
              dependencies = {
                "saadparwaiz1/cmp_luasnip",
                "rafamadriz/friendly-snippets",
              },
              -- keys = require("config.keymaps").setup_snippets_keymaps(),
            },
          },
        },
        { "hrsh7th/cmp-cmdline" },
      },
      opts = function(_, opts)
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()
        local luasnip = require("luasnip")

        local sources = opts.sources or {}
        vim.list_extend(sources, {
          {
            name = "nvim_lsp",
            entry_filter = function(entry)
              -- this will stop the snippet suggestions in jsx to make everything a component, for example you type "useSta" and the first suggestion would be <useSta></useSta>
              return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
          },
          { name = "path" },
          custom_opts.disable_feature.snippets and {} or { name = "luasnip" },
          { name = "buffer" },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            {
              name = "cmdline",
              option = {
                ignore_cmds = { "Man", "!" },
              },
            },
          }),
        })

        return {
          performance = {
            max_view_entries = custom_opts.misc.completion_suggestions_count,
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          window = custom_opts.disable_feature.cmp_border and {} or {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            [custom_opts.keys.cmp.abort] = cmp.mapping.abort(),
            [custom_opts.keys.cmp.confirm] = cmp.mapping.confirm({ select = true }),
            [custom_opts.keys.cmp.select_next_item] = cmp.mapping.select_next_item(),
            [custom_opts.keys.cmp.select_prev_item] = cmp.mapping.select_prev_item(),
            [custom_opts.keys.cmp.scroll_docs_up] = cmp.mapping.scroll_docs(-4),
            [custom_opts.keys.cmp.scoll_docs_down] = cmp.mapping.scroll_docs(4),
            [custom_opts.keys.cmp.complete] = cmp.mapping.complete({}),
            [custom_opts.keys.cmp.goto_next_snippet_placeholder] = cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { "i", "s" }),
            [custom_opts.keys.cmp.goto_prev_snippet_placeholder] = cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources(sources),
        }
      end,
    },
  }
end
