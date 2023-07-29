return {
  "jose-elias-alvarez/null-ls.nvim",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
  },
  opts = function()
    local null_ls = require("null-ls")
    return {
      sources = {
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.gitsigns,
      },
    }
  end,
}
