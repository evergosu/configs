return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    {
      'williamboman/mason-lspconfig.nvim',
      opts = {
        ensure_installed = { "lua_ls" },
      },
    },
    {
      'j-hui/fidget.nvim',
      event = "LspAttach",
      tag = 'legacy',
      config = true,
    },
    { 'folke/neodev.nvim', config = true },
  },
  ---@class PluginLspOpts
  opts = {
    autoformat = true,
    servers = {
      lua_ls = {},
    },
  },
  config = function()
    vim.keymap.set('n', '<space>Le', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>Lq', vim.diagnostic.setloclist)

    require'lspconfig'.lua_ls.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end,
}
