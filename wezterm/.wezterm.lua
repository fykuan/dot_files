local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

config = {
    font = wezterm.font_with_fallback {
        'Hack',
        "PingFang TC",          -- 中文字體 fallback
        "Noto Color Emoji",     -- 表情符號
    },
    font_size = 12.0,
    color_scheme = 'Tomorrow Night Eighties',
    -- Window size controls
    initial_cols = 160,
    initial_rows = 50,
    -- Tab controls
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    -- Apperence controls
    text_background_opacity = 1.0,
    window_background_opacity = 1.0,
    -- Scrolling controls
    scrollback_lines = 1500,
    -- Font controls
    freetype_load_flags = "DEFAULT",

    -- 20240203 版 mouse，請用 enable_mouse_reporting
    enable_mouse_reporting = true,
}

config.colors = {
    tab_bar = {
        -- inactive_tab_edge = '#000000',
    }
}

return config
