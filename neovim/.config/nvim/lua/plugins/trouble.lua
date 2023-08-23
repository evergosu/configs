return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'TroubleToggle', 'Trouble' },
  opts = {
    action_keys = {
      open_vsplit = { '<s-cr>' },
      open_split = { '<c-cr>' },
    },
    auto_jump = {
      'lsp_references',
      'lsp_definitions',
    },
    include_declaration = {
      'lsp_definitions',
      'lsp_implementations',
    },
    auto_close = true,
    use_diagnostic_signs = true,
    win_config = { border = 'double' },
  },
  keys = function()
    require('which-key').register({
      ['<leader>t'] = { name = 'trouble' },
    })

    return {
      { 'gr', '<cmd>TroubleToggle lsp_references<cr>', desc = '[LSP]: references' },
      { 'gd', '<cmd>TroubleToggle lsp_definitions<cr>', desc = '[LSP]: definitions' },
      { 'gt', '<cmd>TroubleToggle lsp_type_definitions<cr>', desc = '[LSP]: type definitions' },
      { '<leader>tt', '<cmd>TroubleToggle<cr>', desc = 'toggle' },
      { '<leader>tl', '<cmd>TroubleToggle loclist<cr>', desc = 'location list' },
      { '<leader>tq', '<cmd>TroubleToggle quickfix<cr>', desc = 'quickfix list' },
      {
        '<C-l>',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            local ok = pcall(vim.cmd.cnext)
            if not ok then
              pcall(vim.cmd.crewind)
            end
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
      {
        '<CA-l>',
        function()
          if require('trouble').is_open() then
            require('trouble').previous({ skip_groups = true, jump = true })
          else
            local ok = pcall(vim.cmd.cprev)
            if not ok then
              pcall(vim.cmd.clast)
            end
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
    }
  end,
}
