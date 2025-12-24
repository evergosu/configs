local M = {}

function M.setup()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup({
    spec = {
      { import = 'plugins' },
      { import = 'plugins.lsp' },
    },
    defaults = {
      version = false,
      lazy = true,
    },
    checker = {
      enabled = true,
      notify = false,
    },
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          'netrwPlugin',
          'tutor',
        },
      },
    },
  })
end

function M.map(mode, lhs, rhs, opts)
  local keys = require('lazy.core.handler').handlers.keys

  -- Do not create the keymap if a lazy keys handler exists.
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    opts.remap = opts.remap and nil
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require('lazy.core.config')
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    vim.schedule(function()
      fn(name)
    end)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
