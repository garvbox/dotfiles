local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'GruvboxDark'
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
-- This is supposed to be the default setting, but somehow it needs to be set,
-- otherwise the fonts look skinny and weird next to alacritty
config.front_end = "WebGpu"

return config
