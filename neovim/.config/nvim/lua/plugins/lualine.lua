local function make_bufferline(icons)
  return function()
    local function iconify(b)
      if 1 ~= vim.fn.buflisted(b) then
        return ''
      elseif b == vim.fn.winbufnr(0) then
        return icons.current
      elseif -1 ~= vim.fn.bufwinnr(b) then
        return icons.split
      else
        return icons.hidden
      end
    end

    return table.concat(vim.tbl_map(iconify, vim.api.nvim_list_bufs()))
  end
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
            make_bufferline({
              current = icons.ui.Current,
              hidden = icons.ui.Hidden,
              split = icons.ui.Split,
            }),
            padding = { right = 0 },
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
              added = icons.git.Added,
              modified = icons.git.Modified,
              removed = icons.git.Removed,
            },
          },
        },
        lualine_y = {
          { 'location', padding = { right = 1 } },
        },
        lualine_z = {
          {
            function()
              return require('config.icons').ui.Package
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
