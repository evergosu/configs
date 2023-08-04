return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find help tags' },
    },
    opts = {
      defaults = {
        mappings = {
          n = {
            ['q'] = function(...)
              return require('telescope.actions').close(...)
            end,
          },
        },
      },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },
}
