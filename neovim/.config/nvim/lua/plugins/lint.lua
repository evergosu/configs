return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePost', 'BufEnter' },
  ft = { 'lua' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      lua = { 'selene' },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
