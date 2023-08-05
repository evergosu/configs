local on_attach = function(_, bufnr)
  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gi', vim.lsp.buf.implementation)
  bufmap('gt', vim.lsp.buf.type_definition)
  bufmap('K', vim.lsp.buf.hover)
  bufmap('<C-k>', vim.lsp.buf.signature_help)
  bufmap('<space>rn', vim.lsp.buf.rename)
  bufmap('<space>ca', vim.lsp.buf.code_action)

  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('gs', require('telescope.builtin').lsp_document_symbols)
  bufmap('gS', require('telescope.builtin').lsp_dynamic_workspace_symbols)
end

return {
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    tag = 'legacy',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'folke/neodev.nvim',
    },
    config = function()
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require('mason').setup()
      require('mason-lspconfig').setup({
        automatic_installation = false,
        ensure_installed = {
          'lua_ls',
        },
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        ['lua_ls'] = function()
          require('neodev').setup()
          require('lspconfig').lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                telemetry = { enable = false },
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                  checkThirdParty = false,
                  library = vim.api.nvim_get_runtime_file('', true),
                },
              },
            },
          })
        end,
      })
    end,
  },
}
