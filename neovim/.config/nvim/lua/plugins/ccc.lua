return {
  'uga-rosa/ccc.nvim',
  keys = function()
    require('which-key').register({
      ['<leader>P'] = { name = 'picker' },
    })

    return {
      { '<leader>Pp', '<cmd>CccPick<cr>', desc = 'pick' },
      { '<leader>Pc', '<cmd>CccConvert<cr>', desc = 'convert' },
      { '<leader>Ph', '<cmd>CccHighlighterToggle<cr>', desc = 'highlight' },
    }
  end,
  config = function()
    local ccc = require('ccc')

    ccc.setup({
      win_opts = {
        border = 'double',
      },
      highlighter = {
        lsp = true,
      },
      inputs = {
        ccc.input.rgb,
        ccc.input.hsl,
        ccc.input.oklch,
      },
      outputs = {
        ccc.output.hex,
        ccc.output.hex_short,
        ccc.output.css_rgb,
        ccc.output.css_hsl,
        ccc.output.css_oklch,
      },
      convert = {
        { ccc.picker.hex, ccc.output.css_rgb },
        { ccc.picker.css_rgb, ccc.output.css_hsl },
        { ccc.picker.css_hsl, ccc.output.css_oklch },
        { ccc.picker.css_oklch, ccc.output.hex },
      },
    })
  end,
}
