return {
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  tag = 'legacy',
  opts = {
    text = {
      spinner = 'star',
      done = '✔',
      commenced = '',
      completed = '',
    },
    fmt = { task = function() end },
  },
}
