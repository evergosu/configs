return {
  'kdheepak/lazygit.nvim',
  event = 'VeryLazy',
  keys = function()
    require('which-key').register({
      ['<leader>g'] = { name = 'git' },
    })

    return {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'gui' },
    }
  end,
}
