return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  keys = function()
    require('which-key').register({
      ['<leader>g'] = { name = 'git' },
    })

    return {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'gui' },
    }
  end,
  config = function()
    require('telescope').load_extension('lazygit')
  end,
}
