-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "/themes/wayfarer/theme.lua")

-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Hide empty tags
local eminent = require("eminent.eminent")

-- Helpers functions
local helpers = require("helpers")

-- Custom Widgets
local widgets = require("widgets")

-- Set up root keys and buttons
local keys = require("keys")
root.keys(keys.global_keys)
root.buttons(keys.desktop_buttons)

-- Set up client rules
local rules = require("rules")
awful.rules.rules = rules.create(keys.client_keys, keys.client_buttons)

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Table of layouts to cover with awful.layout.inc. Order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.floating,
    awful.layout.suit.corner.ne,
    awful.layout.suit.corner.nw
}
-- }}}

-- {{{ Wibar
-- Create systray widget (holds systray icons for apps who provide them).
mysystray = wibox.widget.systray()

-- Setup wiboxes, tags and wallpaper for each screen
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    helpers.set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, keys.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, keys.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18 })

    local left_sublayout = wibox.layout.fixed.horizontal()
    local right_sublayout = wibox.layout.fixed.horizontal()
    local layout = wibox.layout.align.horizontal()

    -- Left widgets
    left_sublayout:add(s.mytaglist)
    left_sublayout:add(s.mypromptbox)

    -- Right widgets
    if s.index == 2 then
        mysystray.set_screen(s)
        right_sublayout:add(mysystray)
    end

    local bg_color_1 = "#44475a"
    local bg_color_2 = "#6272a4"

    right_sublayout:add(widgets.get_left_arrow("alpha", bg_color_1))
    right_sublayout:add(widgets.get_widget("mem", bg_color_1, 3, 4))

    right_sublayout:add(widgets.get_left_arrow(bg_color_1, bg_color_2))
    right_sublayout:add(widgets.get_widget("cpu", bg_color_2, 4, 4))

    right_sublayout:add(widgets.get_left_arrow(bg_color_2, bg_color_1))
    right_sublayout:add(widgets.get_widget("fs", bg_color_1, 3, 3))

    right_sublayout:add(widgets.get_left_arrow(bg_color_1, bg_color_2))
    right_sublayout:add(widgets.get_widget("net", bg_color_2, 3, 3))

    right_sublayout:add(widgets.get_left_arrow(bg_color_2, bg_color_1))
    right_sublayout:add(widgets.get_widget("clock", bg_color_1, 4, 8))

    right_sublayout:add(widgets.get_left_arrow(bg_color_1, bg_color_2))
    right_sublayout:add(widgets.wrap_widget(nil, s.mylayoutbox, bg_color_2, 0, 0))

    -- Putting everything together
    layout:set_left(left_sublayout)
    layout:set_middle(s.mytasklist)
    layout:set_right(right_sublayout)

    s.mywibox:set_widget(layout)
end)
-- }}}

-- {{{ Signals

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", helpers.set_wallpaper)

-- The "manage" signal is emitted when new clients are created.
client.connect_signal("manage", function (c)
    -- Set new clients as secondary.
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Focus client on mouseover.
client.connect_signal("mouse::enter", function(c)
    client.focus = c
end)

-- Transfer focus to previous client when a client is closed.
require("awful.autofocus")

client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.shape = gears.shape.rectangle
    else
        c.shape = gears.shape.rounded_rect
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
