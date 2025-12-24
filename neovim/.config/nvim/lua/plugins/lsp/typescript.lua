return {
  -- TODO: see for replacement https://github.com/yioneko/vtsls
  'pmizio/typescript-tools.nvim',
  ft = {
    'javascript',
    'javascript.jsx',
    'javascriptreact',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
  },
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    require('typescript-tools').setup({
      on_attach = function(_, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr })

        require('which-key').add({ '<leader>ll', name = 'language' }, { buffer = bufnr })

        local set = vim.keymap.set
        local opts = { buffer = bufnr, silent = true }

        opts.desc = 'fix all errors'
        set('n', '<leader>llf', '<cmd>TSToolsFixAll<cr>', opts)
        opts.desc = 'organize imports'
        set('n', '<leader>llo', '<cmd>TSToolsOrganizeImports<cr>', opts)
        opts.desc = 'remove unused statements'
        set('n', '<leader>llu', '<cmd>TSToolsRemoveUnused<cr>', opts)
        opts.desc = 'add missing imports'
        set('n', '<leader>lla', '<cmd>TSToolsAddMissingImports<cr>', opts)
        opts.desc = 'go to source definition'
        set('n', '<leader>lld', '<cmd>TSToolsGoToSourceDefinition<cr>', opts)
        opts.desc = 'rename current file'
        set('n', '<leader>llr', '<cmd>TSToolsRenameFile<cr>', opts)
        opts.desc = 'find file references'
        set('n', '<leader>llR', '<cmd>TSToolsFileReferences<cr>', opts)
      end,
      settings = {
        expose_as_code_action = 'all',
        tsserver_format_options = {
          semicolons = 'insert',
        },
        tsserver_file_preferences = {
          quotePreference = 'single',
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        },
        complete_function_calls = true,
      },
    })
  end,
}
