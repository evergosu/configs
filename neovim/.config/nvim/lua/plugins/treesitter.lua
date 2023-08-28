return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    cmd = { 'TSUpdateSync' },
    keys = {
      { '<s-cr>', desc = 'Increment selection' },
      { '<bs>', desc = 'Decrement selection', mode = 'x' },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        'bash',
        'c',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'regex',
        'vim',
        'vimdoc',
        'yaml',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<s-cr>',
          node_incremental = '<cr>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      context_commentstring = {
        enable = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      require('treesitter-context').setup({ max_lines = 1 })

      vim.api.nvim_set_hl(0, 'TreesitterContext', {
        bold = true,
        italic = true,
      })
    end,
  },
}
