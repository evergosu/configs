return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'Spectre',
  keys = function()
    require('which-key').register({
      ['<leader>s'] = { name = 'search' },
    })

    return {
      {
        '<leader>sf',
        function()
          require('spectre').open_file_search({ select_word = true })
        end,
        desc = 'file',
      },
      {
        '<leader>sp',
        function()
          require('spectre').open({
            cwd = vim.system({ 'git', 'rev-parse', '--show-toplevel' }):wait().stdout:gsub('\n', '') or vim.loop.cwd(),
          })
        end,
        desc = 'project',
      },
    }
  end,
  opts = function()
    return { open_cmd = 'noswapfile vnew' }
  end,
}
