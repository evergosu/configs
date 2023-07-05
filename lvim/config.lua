vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.wo.foldlevel = 99
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

lvim.log.level = "warn"
lvim.colorscheme = "onedarker"
lvim.transparent_window = true
lvim.lsp.diagnostics.virtual_text = false
lvim.format_on_save = {
  enabled = true,
  timeout = 1000,
  pattern = {
    "*.lua",
    "*.rs"
  },
}

lvim.leader = "space"
lvim.keys.normal_mode["<s-l>"] = ":BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<s-h>"] = ":BufferLineCyclePrev<cr>"
lvim.builtin.terminal.open_mapping = "<c-t>"
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitioas<cr>", "Definitions" },
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

lvim.keys.normal_mode["<c-a>"] = ":DialIncrement<cr>"
lvim.keys.normal_mode["<c-x>"] = ":DialDecrement<cr>"

lvim.builtin.dap.active = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.auto_install = true

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
  { "lilydjwg/colorizer" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group {
        default = {
          augend.semver.alias.semver,
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%d/%m/%Y"],
          augend.constant.alias.bool,
          augend.constant.new {
            elements = { "let", "const" },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "on", "off" },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          },
        },
      }
    end
  },
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

  vt.setup { commented = true }

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
