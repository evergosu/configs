return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'debugloop/telescope-undo.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-web-devicons',
    },
    version = false,
    cmd = 'Telescope',
    keys = function()
      local TB = require('telescope.builtin')

      return {
        -- stylua: ignore start
        { '<leader>F',  TB.builtin,                desc = '[F]ind in telescope' },
        { '<leader>fb', TB.buffers,                desc = '[F]ind in [B]uffers' },
        { '<leader>ff', TB.find_files,             desc = '[F]ind in [F]iles' },
        { '<leader>fg', TB.git_files,              desc = '[F]ind in [G]it' },
        { '<leader>ft', TB.live_grep,              desc = '[F]ind as [T]ext' },
        { '<leader>fh', TB.help_tags,              desc = '[F]ind in [H]elp' },
        { '<leader>fd', TB.diagnostics,            desc = '[F]ind in [D]iagnostics' },
        { '<leader>fl', TB.quickfix,               desc = '[F]ind in Quickfix [L]ist' },
        { '<leader>fL', TB.quickfixhistory,        desc = '[F]ind in Quickfix [L]ists' },
        { '<leader>fu', '<cmd>Telescope undo<cr>', desc = '[F]ind in [U]ndo history' },
        -- stylua: ignore end
      }
    end,
    opts = function()
      local TB = require('telescope.builtin')
      local TA = require('telescope.actions')
      local TLA = require('telescope.actions.layout')
      local TUA = require('telescope-undo.actions')

      return {
        defaults = {
          mappings = {
            i = {
              ['<C-c>'] = false,
              ['<esc>'] = TA.close,

              ['<C-p>'] = TLA.toggle_preview,
              ['<C-n>'] = TLA.cycle_layout_next,

              ['<C-j>'] = TA.move_selection_next,
              ['<C-k>'] = TA.move_selection_previous,

              ['<C-x>'] = false,
              ['<C-v>'] = false,

              ['<S-CR>'] = TA.select_vertical,
              ['<C-CR>'] = TA.select_horizontal,

              ['<C-l>'] = function(...)
                TA.smart_send_to_qflist(...)
                TB.quickfix()
              end,
            },
          },
        },
        pickers = {
          builtin = { use_default_opts = true },
          help_tags = { previewer = false, theme = 'dropdown' },
          live_grep = { previewer = false, theme = 'dropdown' },
          diagnostics = { previewer = false, theme = 'dropdown' },
          quickfix = { previewer = false, theme = 'dropdown' },
          quickfixhistory = { previewer = false, theme = 'dropdown' },
          git_files = { previewer = false, theme = 'dropdown', hidden = true },
          find_files = { previewer = false, theme = 'dropdown', hidden = true },
          buffers = {
            mappings = {
              i = {
                ['<c-d>'] = TA.delete_buffer + TA.move_to_top,
              },
            },
            show_all_buffers = true,
            sort_lastused = true,
            theme = 'dropdown',
            previewer = false,
          },
        },
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = 'vertical',
            layout_config = {
              preview_height = 0.7,
            },
            mappings = {
              i = {
                ['<cr>'] = TUA.yank_additions,
                ['<S-cr>'] = TUA.yank_deletions,
                ['<C-cr>'] = TUA.restore,
              },
            },
          },
          ['ui-select'] = {
            require('telescope.themes').get_cursor(),
          },
        },
      }
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').load_extension('ui-select')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'debugloop/telescope-undo.nvim',
    config = function()
      require('telescope').load_extension('undo')
    end,
  },
}
