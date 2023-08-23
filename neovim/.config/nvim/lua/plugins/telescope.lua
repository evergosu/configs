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
      require('which-key').register({
        ['<leader>f'] = { name = 'find' },
      })

      return {
        -- stylua: ignore start
        { '<leader>ft', '<cmd>Telescope builtin<cr>',         desc = 'telescope' },
        { '<leader>fb', '<cmd>Telescope buffers<cr>',         desc = 'buffers' },
        { '<leader>ff', '<cmd>Telescope find_files<cr>',      desc = 'files' },
        { '<leader>fp', '<cmd>Telescope git_files<cr>',       desc = 'project' },
        { '<leader>fg', '<cmd>Telescope live_grep<cr>',       desc = 'grep' },
        { '<leader>fr', '<cmd>Telescope oldfiles<cr>',        desc = 'recent files' },
        { '<leader>fR', '<cmd>Telescope lazygit<cr>',         desc = 'recent repos' },
        { '<leader>fh', '<cmd>Telescope help_tags<cr>',       desc = 'help' },
        { '<leader>fd', '<cmd>Telescope diagnostics<cr>',     desc = 'diagnostics' },
        { '<leader>fu', '<cmd>Telescope undo<cr>',            desc = 'undo history' },
        { '<leader>fl', '<cmd>Telescope quickfix<cr>',        desc = 'list quickfix' },
        { '<leader>fL', '<cmd>Telescope quickfixhistory<cr>', desc = 'list quickfix history' },
        -- stylua: ignore end
      }
    end,
    opts = function()
      local TB = require('telescope.builtin')
      local TA = require('telescope.actions')
      local TLA = require('telescope.actions.layout')
      local TUA = require('telescope-undo.actions')
      local trouble = require('trouble.providers.telescope')

      return {
        defaults = {
          layout_strategy = 'vertical',
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

              ['<C-t>'] = trouble.open_with_trouble,
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
          live_grep = {
            previewer = false,
            theme = 'dropdown',
            additional_args = function()
              return { '--hidden' }
            end,
          },
          oldfiles = { previewer = false, theme = 'dropdown' },
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
