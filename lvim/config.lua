vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.cmdheight = 0
vim.wo.foldlevel = 99
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
lvim.transparent_window = true
lvim.lsp.diagnostics.virtual_text = false

lvim.leader = "space"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<cr>"
lvim.builtin.terminal.open_mapping = "<c-t>"
lvim.builtin.which_key.mappings["dT"] = { "<cmd>lua require'dapui'.toggle({ reset = true })<cr>", "Toggle UI" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}
lvim.builtin.which_key.mappings["r"] = {
  name = "Rust tools",
  a = { "<cmd>RustCodeAction<cr>", "Code" },
  d = { "<cmd>RustDebuggables<cr>", "Debug" },
  h = { "<cmd>RustHoverActions<cr>", "Hover" },
  r = { "<cmd>RustRunnables<cr>", "Run" }
}

lvim.builtin.dap.active = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
}

-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').set_default_keymaps()
    end
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup()
    end
  },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
  },
  { "theHamsta/nvim-dap-virtual-text" },
  { "nvim-telescope/telescope-dap.nvim" },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local extension_path = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

      local opts = {
        dap = {
          adapter = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            console = "internalConsole",
            executable = {
              command = codelldb_path,
              args = { "--liblldb", liblldb_path, "--port", "${port}" },
            },
          }
        },
        tools = {
          executor = require("rust-tools/executors").termopen,
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          runnables = {
            use_telescope = true
          },
          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = true,
          },
        },
        server = {
          on_init = require("lvim.lsp").common_on_init,
          on_attach = require("lvim.lsp").common_on_attach,
          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                allFeatures = true,
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true
              },
              checkOnSave = {
                features = "all",
                command = "clippy",
              }
            }
          }
        }
      }

      require("rust-tools").setup(opts)
    end,
    ft = { "rust", "rs" },
  }
}
---@diagnostic disable-next-line: missing-parameter
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- Debug Adapter Protocols
lvim.builtin.dap.on_config_done = function(dap)
  local vt = require("nvim-dap-virtual-text");
  local ui = require("dapui");

  dap.listeners.after.event_initialized["dapui_config"] = function()
    ui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    ui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    ui.close()
  end

  vt.setup { commented = true }

  ui.setup({
    layouts = {
      {
        elements = {
          "scopes",
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 50,
        position = "left",
      },
      {
        elements = {
          "repl",
        },
        size = 0.25,
        position = "bottom",
      },
    },
  })

  dap.configurations.rust = {
    {
      name = "Debug",
      type = "rt_lldb",
      request = "launch",
      program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
      cwd = "${workspaceFolder}",
      console = "internalConsole"
    },
  }
end

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "dap")
end
