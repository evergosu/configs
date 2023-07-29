return {
  { "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" }
    },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        "lua_ls"
      },
    },
  },
}
