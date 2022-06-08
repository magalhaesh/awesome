---------------------------
-- Modified Default awesome theme --
---------------------------

local theme_name = "wayfarer"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local themes_path = "~/.config/awesome/themes/"
local theme_path = themes_path .. theme_name .. "/"

local theme = {}

theme.font = "DejaVu Sans Code 8"

theme.bg_normal = "#282a36"
theme.bg_focus = "#9474d4"
theme.bg_urgent = "#5236C4"
theme.bg_minimize = "#000000"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#000000"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.border_width = dpi(1)
theme.border_normal = "#1c2022"
theme.border_focus = "#8e71b7"
theme.border_marked = "#3ca4d8"

theme.widget_fg_normal = "#fefefe"
theme.useless_gap = dpi(2)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(10)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Titlebar icons. Not really used on this theme, but who knows.
local titlebar_icon_path = themes_path .. "default/titlebar/"

theme.titlebar_close_button_normal = titlebar_icon_path .. "close_normal.png"
theme.titlebar_close_button_focus  = titlebar_icon_path .. "close_focus.png"

theme.titlebar_minimize_button_normal = titlebar_icon_path .. "minimize_normal.png"
theme.titlebar_minimize_button_focus  = titlebar_icon_path .. "minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = titlebar_icon_path .. "ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = titlebar_icon_path .. "ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = titlebar_icon_path .. "ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = titlebar_icon_path .. "ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = titlebar_icon_path .. "sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = titlebar_icon_path .. "sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = titlebar_icon_path .. "sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = titlebar_icon_path .. "sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = titlebar_icon_path .. "floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = titlebar_icon_path .. "floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = titlebar_icon_path .. "floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = titlebar_icon_path .. "floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = titlebar_icon_path .. "maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = titlebar_icon_path .. "maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = titlebar_icon_path .. "maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = titlebar_icon_path .. "maximized_focus_active.png"

theme.wallpaper = theme_path .. "background.png"

-- Layout icons.
local layout_icon_path = themes_path .. "default/layouts/"

theme.layout_fairh = layout_icon_path .. "fairhw.png"
theme.layout_fairv = layout_icon_path .. "fairvw.png"
theme.layout_floating  = layout_icon_path .. "floatingw.png"
theme.layout_magnifier = layout_icon_path .. "magnifierw.png"
theme.layout_max = layout_icon_path .. "maxw.png"
theme.layout_fullscreen = layout_icon_path .. "fullscreenw.png"
theme.layout_tilebottom = layout_icon_path .. "tilebottomw.png"
theme.layout_tileleft   = layout_icon_path .. "tileleftw.png"
theme.layout_tile = layout_icon_path .. "tilew.png"
theme.layout_tiletop = layout_icon_path .. "tiletopw.png"
theme.layout_spiral  = layout_icon_path .. "spiralw.png"
theme.layout_dwindle = layout_icon_path .. "dwindlew.png"
theme.layout_cornernw = layout_icon_path .. "cornernww.png"
theme.layout_cornerne = layout_icon_path .. "cornernew.png"
theme.layout_cornersw = layout_icon_path .. "cornersww.png"
theme.layout_cornerse = layout_icon_path .. "cornersew.png"

-- Widget icons.
local icon_path = theme_path .. "icons/"

theme.widget_ac = icon_path .. "ac.png"
theme.widget_battery = icon_path .. "battery.png"
theme.widget_battery_low = icon_path .. "battery_low.png"
theme.widget_battery_empty = icon_path .. "battery_empty.png"
theme.widget_mem = icon_path .. "mem.png"
theme.widget_cpu = icon_path .. "cpu.png"
theme.widget_temp = icon_path .. "temp.png"
theme.widget_net = icon_path .. "net.png"
theme.widget_hdd = icon_path .. "hdd.png"
theme.widget_music = icon_path .. "note.png"
theme.widget_music_on = icon_path .. "note_on.png"
theme.widget_vol = icon_path .. "vol.png"
theme.widget_vol_low = icon_path .. "vol_low.png"
theme.widget_vol_no = icon_path .. "vol_no.png"
theme.widget_vol_mute = icon_path .. "vol_mute.png"
theme.widget_mail = icon_path .. "mail.png"
theme.widget_mail_on = icon_path .. "mail_on.png"
theme.widget_task = icon_path .. "task.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
