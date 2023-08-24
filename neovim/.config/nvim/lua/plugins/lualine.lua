local function buffers_count()
  local count = #vim.tbl_filter(function(b)
    return vim.fn.buflisted(b) == 1
  end, vim.api.nvim_list_bufs())

  return string.rep('', count, ' ')
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function()
    local icons = require('config.icons')

    return {
      options = {
        component_separators = '',
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = { statusline = { 'alpha' } },
      },
      sections = {
        lualine_a = {
          'mode',
          {
            buffers_count,
            padding = { right = 1 },
          },
        },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filetype',
            icon_only = true,
            padding = {
              left = 1,
              right = 0,
            },
          },
          {
            'filename',
            path = 1,
            file_status = false,
          },
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
          },
        },
        lualine_y = {
          { 'location', padding = { right = 1 } },
        },
        lualine_z = {
          {
            function()
              return require('config.icons').kinds.Package
            end,
            cond = require('lazy.status').has_updates,
            padding = 0,
          },
          {
            'datetime',
            style = '%R',
            padding = { right = 1 },
          },
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    }
  end,
}
