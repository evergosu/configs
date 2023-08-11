return {
  'folke/zen-mode.nvim',
  dependencies = {
    'folke/twilight.nvim',
  },
  keys = {
    { '<leader>m', '<cmd>ZenMode<cr>', desc = 'Toggle zen [M]ode' },
  },
  opts = {
    window = {
      width = 1,
      height = 1,
      backdrop = 1,
    },
  },
}
