local wezterm = require 'wezterm'

local c = wezterm.config_builder()

c.font_size = 16.0
c.color_scheme = 'nord'
c.font = wezterm.font_with_fallback {
  'Fira Code Retina',
  'MesloLGS NF',
}
c.hide_tab_bar_if_only_one_tab = true
c.adjust_window_size_when_changing_font_size = false
c.force_reverse_video_cursor = true

return c
