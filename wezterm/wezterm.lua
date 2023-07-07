local wezterm = require 'wezterm'

return {
  font_size = 16.0,
  color_scheme = 'nord',
  font = wezterm.font 'FiraCode Nerd Font Mono',
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
    top = 20,
    bottom = 0,
    right = 0,
  },
}
