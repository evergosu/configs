return {
  'ThePrimeagen/harpoon',
  keys = function()
    require('which-key').register({
      ['<leader>h'] = { name = 'harpoon' },
    })

    return {
      { '<leader>ht', '<cmd>lua require("harpoon.ui").toggle_quick_menu() <cr>', desc = 'toggle' },
      { '<leader>hh', '<cmd>lua require("harpoon.ui").nav_next() <cr>', desc = 'next' },
      { '<leader>hl', '<cmd>lua require("harpoon.ui").nav_prev() <cr>', desc = 'prev' },
      { '<leader>ha', '<cmd>lua require("harpoon.mark").add_file() <cr>', desc = 'add' },
    }
  end,
  opts = {
    global_settings = {
      excluded_filetypes = {
        'gitcommit',
        'harpoon',
        'alpha',
      },
    },
  },
}
