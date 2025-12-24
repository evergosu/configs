return {
  'simrat39/rust-tools.nvim',
  ft = { 'rust', 'rs' },
  setup = function()
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

          require('which-key').add({ '<leader>ll', name = 'language' }, { buffer = bufnr })

          local set = vim.keymap.set

                -- stylua: ignore start
                set('n', '<leader>llc', '<cmd>RustOpenCargo<cr>',         { buffer = bufnr, desc = 'open cargo.toml' })
                set('n', '<leader>lld', '<cmd>RustMoveItemDown<cr>',      { buffer = bufnr, desc = 'move item down' })
                set('n', '<leader>llu', '<cmd>RustMoveItemUp<cr>',        { buffer = bufnr, desc = 'move item up' })
                set('n', '<leader>lle', '<cmd>RustExpandMacro<cr>',       { buffer = bufnr, desc = 'expand macro' })
                set('n', '<leader>llg', '<cmd>RustViewCrateGraph<cr>',    { buffer = bufnr, desc = 'crate graph' })
                set('n', '<leader>llh', '<cmd>RustEnableInlayHints<cr>',  { buffer = bufnr, desc = 'hints enable' })
                set('n', '<leader>llH', '<cmd>RustDisableInlayHints<cr>', { buffer = bufnr, desc = 'hints disable' })
                set('n', '<leader>llj', '<cmd>RustJoinLines<cr>',         { buffer = bufnr, desc = 'join lines' })
                set('n', '<leader>llo', '<cmd>RustOpenExternalDocs<cr>',  { buffer = bufnr, desc = 'open external docs' })
                set('n', '<leader>llp', '<cmd>RustParentModule<cr>',      { buffer = bufnr, desc = 'parent module' })
                set('n', '<leader>llr', '<cmd>RustLastRun<cr>',           { buffer = bufnr, desc = 'last run' })
                set('n', '<leader>llR', '<cmd>RustRunnables<cr>',         { buffer = bufnr, desc = 'runnables' })
                set('n', '<leader>lls', '<cmd>RustSSR<cr>',               { buffer = bufnr, desc = 'ssr' })
          -- stylua: ignore end
        end,
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
}
