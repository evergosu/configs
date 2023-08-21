return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  vscode = true,
  opts = {
    modes = {
      char = {
        jump_labels = true,
      },
    },
  },
  keys = {
    {
      's',
      mode = 'n',
      function()
        require('flash').jump()
      end,
      desc = 'flash jump',
    },
    {
      's',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'flash remote action',
    },
    {
      '<c-s>',
      mode = 'n',
      function()
        require('flash').jump({
          search = { mode = 'search', max_length = 0 },
          label = { after = { 0, 0 } },
          pattern = '^',
        })
      end,
      desc = 'flash jump line',
    },
  },
}
