return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'Trouble' },
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
    require('which-key').add({ '<leader>T', group = 'trouble' })

    return {
      { 'gr', '<cmd>Trouble lsp_references toggle<cr>', desc = '[LSP]: references' },
      { 'gd', '<cmd>Trouble lsp_definitions toggle<cr>', desc = '[LSP]: definitions' },
      { 'gt', '<cmd>Trouble lsp_type_definitions toggle<cr>', desc = '[LSP]: type definitions' },
      { '<leader>Tt', '<cmd>Trouble diagnostics toggle<cr>', desc = 'diagnostics' },
      { '<leader>Tl', '<cmd>Trouble loclist toggle<cr>', desc = 'location list' },
      { '<leader>Tq', '<cmd>Trouble quickfix toggle<cr>', desc = 'quickfix list' },
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
