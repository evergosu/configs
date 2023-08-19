return {
  'folke/zen-mode.nvim',
  dependencies = {
    'folke/twilight.nvim',
  },
  keys = {
    { '<leader>z', '<cmd>ZenMode<cr>', desc = 'zen' },
  },
  opts = {
    window = {
      width = 1,
      height = 1,
      backdrop = 1,
    },
  },
}
