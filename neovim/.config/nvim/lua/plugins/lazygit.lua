return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazygit' },
    { '<leader>gr', '<cmd>Telescope lazygit<cr>', desc = 'Lazygit repos' },
  },
  config = function()
    require('telescope').load_extension('lazygit')
  end,
}
