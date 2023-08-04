return {
  'ThePrimeagen/harpoon',
  opts = {
    global_settings = {
      excluded_filetypes = {
        'gitcommit',
        'harpoon',
        'alpha',
      },
    },
  },
  config = function(_, opts)
    require('harpoon').setup(opts)
    require('telescope').load_extension('harpoon')

    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')

    vim.keymap.set('n', '<leader>ht', ui.toggle_quick_menu)
    vim.keymap.set('n', '<leader>ha', mark.add_file)
    vim.keymap.set('n', 'gh', function()
      ui.nav_next()
    end)
    vim.keymap.set('n', 'gH', function()
      ui.nav_prev()
    end)
  end,
}
