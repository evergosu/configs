return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'fang2hou/blink-copilot',
      'rafamadriz/friendly-snippets',
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    version = '1.*',
    opts = {
      signature = {
        enabled = true,
        window = {
          show_documentation = false,
        },
      },
      keymap = { preset = 'enter' },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 1000,
        },
      },
      snippets = {
        preset = 'luasnip',
      },
      sources = {
        per_filetype = {
          lua = { inherit_defaults = true, 'lazydev' },
        },
        default = { 'lsp', 'path', 'buffer', 'snippets', 'copilot' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
            fallbacks = { 'lsp' },
          },
          path = {
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 90,
            async = true,
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
