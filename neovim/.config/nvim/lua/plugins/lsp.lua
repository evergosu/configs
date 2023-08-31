local function common_attach(_, bufnr)
  require('which-key').register({
    ['<leader>l'] = { name = 'lsp' },
  }, { buffer = bufnr })

  local set = vim.keymap.set

  local TB = require('telescope.builtin')

  -- stylua: ignore start
  set('n', '[d',         vim.diagnostic.goto_prev,                          { buffer = bufnr, desc = 'Prev diagnostic' })
  set('n', ']d',         vim.diagnostic.goto_next,                          { buffer = bufnr, desc = 'Next diagnostic' })
  set('n', 'K',          vim.lsp.buf.hover,                                 { buffer = bufnr, desc = 'keyword hover' })
  set('n', '<A-k>',      vim.lsp.buf.signature_help,                        { buffer = bufnr, desc = 'keyword signature' })
  set('n', '<leader>la', vim.lsp.buf.code_action,                           { buffer = bufnr, desc = 'actions' })
  set('n', '<leader>ld', TB.lsp_definitions,                                { buffer = bufnr, desc = 'definitions' })
  set('n', '<leader>lD', vim.lsp.buf.declaration,                           { buffer = bufnr, desc = 'declaration' })
  set('n', '<leader>lf', vim.diagnostic.open_float,                         { buffer = bufnr, desc = 'float diagnostic' })
  set('n', '<leader>li', TB.lsp_implementations,                            { buffer = bufnr, desc = 'implementations' })
  set('n', '<leader>lr', vim.lsp.buf.rename,                                { buffer = bufnr, desc = 'rename' })
  set('n', '<leader>lR', TB.lsp_references,                                 { buffer = bufnr, desc = 'references' })
  set('n', '<leader>ls', TB.lsp_document_symbols,                           { buffer = bufnr, desc = 'document symbols' })
  set('n', '<leader>lS', TB.lsp_dynamic_workspace_symbols,                  { buffer = bufnr, desc = 'workspace symbols' })
  set('n', '<leader>lT', TB.lsp_type_definitions,                           { buffer = bufnr, desc = 'type definitions' })
  set('n', 'gL', function() vim.cmd([[call setqflist([], 'r')]]) end,       { buffer = bufnr, desc = 'clear quickfix list' })
  set('n', 'gl', function() vim.diagnostic.setqflist({ open = false }) end, { buffer = bufnr, desc = 'fill quickfix list' })
  -- stylua: ignore end
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
      { 'simrat39/rust-tools.nvim', ft = { 'rust', 'rs' } },
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

      local common_capabilities = vim.lsp.protocol.make_client_capabilities()
      common_capabilities = require('cmp_nvim_lsp').default_capabilities(common_capabilities)

      require('mason').setup()
      require('mason-lspconfig').setup({
        automatic_installation = false,
        ensure_installed = {
          'rust_analyzer',
          'lua_ls',
        },
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            on_attach = common_attach,
            capabilities = common_capabilities,
          })
        end,
        lua_ls = function()
          require('neodev').setup()
          require('lspconfig').lua_ls.setup({
            on_attach = common_attach,
            capabilities = common_capabilities,
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
        rust_analyzer = function()
          local rt = require('rust-tools')

          rt.setup({
            on_initialized = function()
              vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
            end,
            tools = {
              inlay_hints = {
                parameter_hints_prefix = '',
                other_hints_prefix = '',
              },
              hover_actions = {
                border = 'double',
              },
            },
            server = {
              on_attach = function(_, bufnr)
                local augroup = vim.api.nvim_create_augroup('RustLspFormat', {})

                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

                vim.api.nvim_create_autocmd('BufWritePre', {
                  buffer = bufnr,
                  group = augroup,
                  callback = function()
                    -- Reflect clippy changes in current buffer
                    -- and perform language server format afterwards
                    -- to avoid races and inconsistent writes.
                    vim.cmd('silent !cargo clippy --workspace --allow-dirty --quiet --fix')
                    vim.cmd('checktime ' .. bufnr)
                    vim.lsp.buf.format({ name = 'rust_analyzer', bufnr = bufnr })
                  end,
                })

                -- Better keymaps.
                common_attach(_, bufnr)

                require('which-key').register({
                  ['<leader>lt'] = { name = 'rust tools' },
                }, { buffer = bufnr })

                local set = vim.keymap.set

                -- stylua: ignore start
                set('n', '<leader>ltc', '<cmd>RustOpenCargo<cr>',         { buffer = bufnr, desc = 'open cargo.toml' })
                set('n', '<leader>ltd', '<cmd>RustMoveItemDown<cr>',      { buffer = bufnr, desc = 'move item down' })
                set('n', '<leader>ltu', '<cmd>RustMoveItemUp<cr>',        { buffer = bufnr, desc = 'move item up' })
                set('n', '<leader>lte', '<cmd>RustExpandMacro<cr>',       { buffer = bufnr, desc = 'expand macro' })
                set('n', '<leader>ltg', '<cmd>RustViewCrateGraph<cr>',    { buffer = bufnr, desc = 'crate graph' })
                set('n', '<leader>lth', '<cmd>RustEnableInlayHints<cr>',  { buffer = bufnr, desc = 'hints enable' })
                set('n', '<leader>ltH', '<cmd>RustDisableInlayHints<cr>', { buffer = bufnr, desc = 'hints disable' })
                set('n', '<leader>ltj', '<cmd>RustJoinLines<cr>',         { buffer = bufnr, desc = 'join lines' })
                set('n', '<leader>lto', '<cmd>RustOpenExternalDocs<cr>',  { buffer = bufnr, desc = 'open external docs' })
                set('n', '<leader>ltp', '<cmd>RustParentModule<cr>',      { buffer = bufnr, desc = 'parent module' })
                set('n', '<leader>ltr', '<cmd>RustLastRun<cr>',           { buffer = bufnr, desc = 'last run' })
                set('n', '<leader>ltR', '<cmd>RustRunnables<cr>',         { buffer = bufnr, desc = 'runnables' })
                set('n', '<leader>lts', '<cmd>RustSSR<cr>',               { buffer = bufnr, desc = 'ssr' })
                -- stylua: ignore end
              end,
              capabilities = common_capabilities,
              settings = {
                ['rust-analyzer'] = {
                  lens = {
                    enable = true,
                  },
                  imports = {
                    granularity = {
                      group = 'module',
                    },
                    prefix = 'self',
                  },
                  cargo = {
                    allFeatures = true,
                    buildScripts = {
                      enable = true,
                    },
                  },
                  procMacro = {
                    enable = true,
                  },
                  diagnostics = {
                    enable = true,
                    experimental = {
                      enable = true,
                    },
                  },
                  checkOnSave = true,
                  check = {
                    features = 'all',
                    command = 'clippy',
                  },
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
