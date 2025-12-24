return {
  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'copilot',
        'html',
        'cssls',
        'jsonls',
        'yamlls',
        'tailwindcss',
        'rust_analyzer',
        'lua_ls',
        'graphql',
        'emmet_ls',
        'eslint',
        'stylelint_lsp',
      },
    },
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            border = 'double',
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },
      'neovim/nvim-lspconfig',
      { 'b0o/schemastore.nvim', ft = { 'json', 'jsonc' }, version = false },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'prettier',
        'stylua',
        'selene',
      },
    },
    dependencies = {
      'mason-org/mason.nvim',
    },
  },
}
