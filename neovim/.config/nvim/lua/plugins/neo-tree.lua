return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>fe',
      function()
        require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = '[F]ind in [E]xplorer',
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
  opts = {
    window = {
      mappings = {
        ['<space>'] = 'none',
      },
    },
  },
}
