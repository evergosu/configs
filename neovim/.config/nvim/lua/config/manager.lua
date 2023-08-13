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
    spec = { { import = 'plugins' } },
    defaults = { version = false },
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

return M
