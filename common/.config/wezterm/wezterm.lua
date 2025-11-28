local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Moon"

-- Font setup is for large screens on MacOS, using increased font size.
-- Use Alacritty if smaller font is needed
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.initial_rows = 48
config.initial_cols = 160
config.enable_wayland = false

-- This is the default value but is needed to be set explicitly for MacOS
config.front_end = "WebGpu"

return config
