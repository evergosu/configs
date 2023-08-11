return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function()
    local icons = require('config.icons')

    return {
      options = {
        component_separators = '|',
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = { statusline = { 'alpha' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = {
              left = 1,
              right = 0,
            },
          },
          { 'filename', path = 1 },
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
        lualine_x = {
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            separator = '',
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            separator = '',
          },
        },
        lualine_y = {
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            'datetime',
            style = '%R',
          },
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    }
  end,
}
