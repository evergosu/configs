return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require('window-picker').setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              buftype = { 'terminal', 'quickfix' },
            },
          },
        })
      end,
    },
  },
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute({
          toggle = true,
          reveal_force_cwd = true,
        })
      end,
      desc = 'explorer',
      remap = true,
    },
  },
  init = function()
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(tostring(vim.fn.argv(0)))
      if stat and stat.type == 'directory' then
        require('neo-tree')
      end
    end
  end,
  opts = function()
    local icons = require('config.icons')

    return {
      hide_root_node = true,
      close_if_last_window = true,
      popup_border_style = 'double',
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            require('neo-tree.command').execute({ action = 'close' })
          end,
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          always_show = {
            '.config',
          },
        },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ['<space>'] = 'none',
          ['l'] = 'open',
          ['h'] = 'navigate_up',
          ['P'] = { 'toggle_preview', config = { use_float = false } },
          ['<s-l>'] = 'focus_preview',
          ['<s-k>'] = 'prev_git_modified',
          ['<s-j>'] = 'next_git_modified',
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = icons.git.Added,
            deleted = icons.git.Removed,
            modified = icons.git.Modified,
            renamed = '󰁕',
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
          align = 'right',
        },
        diagnostics = {
          symbols = {
            hint = icons.diagnostics.Hint,
            info = icons.diagnostics.Info,
            warn = icons.diagnostics.Warn,
            error = icons.diagnostics.Error,
          },
        },
      },
    }
  end,
}
