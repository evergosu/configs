return {
  'echasnovski/mini.indentscope',
  version = false,
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'alpha',
        'help',
        'lazy',
        'mason',
        'neo-tree',
        'nnn',
        'Trouble',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
        vim.schedule(function()
          ---@diagnostic disable: undefined-global
          if MiniIndentscope then
            MiniIndentscope.undraw()
          end
        end)
      end,
    })
  end,
  config = function()
    local mis = require('mini.indentscope')

    mis.setup({
      draw = {
        delay = 0,
        animation = mis.gen_animation.none(),
      },
    })
  end,
}
