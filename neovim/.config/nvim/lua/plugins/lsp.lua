local function on_attach(_, bufnr)
  local function bufmap(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local TB = require('telescope.builtin')

  bufmap('K', vim.lsp.buf.hover, '[K]eyword hover')
  bufmap('<C-k>', vim.lsp.buf.signature_help, '[K]eyword signature help')
  bufmap('<space>lr', vim.lsp.buf.rename, '[L]sp: [R]ename')
  bufmap('<space>la', vim.lsp.buf.code_action, '[L]sp: code [A]ction')
  bufmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  bufmap('gr', TB.lsp_references, '[G]oto [R]eferences')
  bufmap('gd', TB.lsp_definitions, '[G]oto [D]efinitions')
  bufmap('gi', TB.lsp_implementations, '[G]oto [I]mplementations')
  bufmap('gt', TB.lsp_type_definitions, '[G]oto [T]ype definitions')
  bufmap('gs', TB.lsp_document_symbols, '[G]oto document [S]ymbols')
  bufmap('gS', TB.lsp_dynamic_workspace_symbols, '[G]oto workspace [S]ymbols')
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
