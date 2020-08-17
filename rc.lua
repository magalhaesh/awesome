-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

-- Initialize theme
beautiful.init(
    gears.filesystem.get_configuration_dir() ..
    "/themes/wayfarer/theme.lua"
)

-- Helpers functions
local helpers = require("helpers")

-- Custom Wibar
local bar = require("bar")

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

-- Setup wiboxes, tags and wallpaper for each screen
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    helpers.set_wallpaper(s)

    -- Tag table
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create bar
    bar.setup(s, keys)
end)

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
