return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'Spectre',
  opts = { open_cmd = 'noswapfile vnew' },
  keys = {
    { '<leader>s', desc = '[S]earch and replace' },
    {
      '<leader>sf',
      function()
        require('spectre').open_file_search({ select_word = true })
      end,
      desc = 'in [F]ile',
    },
    {
      '<leader>sp',
      function()
        require('spectre').open({
          cwd = vim.system({ 'git', 'rev-parse', '--show-toplevel' }):wait().stdout:gsub('\n', '') or vim.loop.cwd(),
        })
      end,
      desc = 'in [P]roject',
    },
  },
}
