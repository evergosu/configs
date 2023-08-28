local function on_attach(_, bufnr)
  require('which-key').register({
    ['<leader>l'] = { name = 'lsp' },
  }, { buffer = bufnr })

  local function bufmap(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local TB = require('telescope.builtin')

  bufmap('K', vim.lsp.buf.hover, 'keyword hover')
  bufmap('<A-k>', vim.lsp.buf.signature_help, 'keyword signature help')
  bufmap('<leader>lr', vim.lsp.buf.rename, 'rename')
  bufmap('<leader>la', vim.lsp.buf.code_action, 'actions')
  bufmap('<leader>ld', vim.diagnostic.open_float, 'diagnostic')
  bufmap('<leader>lD', vim.lsp.buf.declaration, 'declaration')
  bufmap('<leader>lR', TB.lsp_references, 'references')
  bufmap('<leader>ld', TB.lsp_definitions, 'definitions')
  bufmap('<leader>li', TB.lsp_implementations, 'implementations')
  bufmap('<leader>lt', TB.lsp_type_definitions, 'type definitions')
  bufmap('<leader>ls', TB.lsp_document_symbols, 'document symbols')
  bufmap('<leader>lS', TB.lsp_dynamic_workspace_symbols, 'workspace symbols')

  bufmap('gl', function()
    vim.diagnostic.setqflist({ open = false })
  end, 'list diagnostics in quickfix list')

  bufmap('gL', function()
    vim.cmd([[call setqflist([], 'r')]])
  end, 'clear quickfix list')

  bufmap('[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
  bufmap(']d', vim.diagnostic.goto_next, 'Next diagnostic')
end

return {
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    tag = 'legacy',
    opts = {
      text = {
        spinner = 'star',
        done = '✔',
        commenced = '',
        completed = '',
      },
      fmt = { task = function() end },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'b0o/SchemaStore.nvim', version = false },
      'nvim-lua/plenary.nvim',
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'folke/neodev.nvim',
    },
    config = function()
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'double',
      })

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'double',
      })

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
        lua_ls = function()
          require('neodev').setup()
          require('lspconfig').lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                telemetry = {
                  enable = false,
                },
                runtime = {
                  version = 'LuaJIT',
                },
                workspace = {
                  checkThirdParty = false,
                  library = { vim.env.VIMRUNTIME },
                },
              },
            },
          })
        end,
        jsonls = {
          -- Lazy-load.
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              -- Auto-load.
              -- schemas = require('schemastore').json.schemas(),
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
      })
    end,
  },
}
