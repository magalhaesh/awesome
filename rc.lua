-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Hide empty tags
local eminent = require("eminent.eminent")

-- Layouts, widgets and utilities
local lain = require("lain")

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
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(".config/awesome/themes/wayfarer/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    awful.layout.suit.floating,
    awful.layout.suit.corner.nw,
    awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar

-- Systray (holds systray icons for apps who provide them)
mysystray = wibox.widget.systray()

local markup = lain.util.markup

-- MEM
local memicon = wibox.widget.imagebox(beautiful.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal ," " .. cpu_now.usage .. "% "))
    end
})

-- System Temperature
-- local tempicon = wibox.widget.imagebox(beautiful.widget_temp)
-- local temp = lain.widget.temp({
--     settings = function()
--         widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal, " " .. coretemp_now .. "°C "))
--      end
-- })

-- Space available on filesystem
local fsicon = wibox.widget.imagebox(beautiful.widget_hdd)
local fs = lain.widget.fs({
    options  = "--exclude-type=tmpfs",
    notification_preset = { fg = beautiful.fg_normal, bg = beautiful.bg_normal, font = "Hack 8" },
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal, " " .. fs_now.available_gb .. "GB "))
    end
})

-- Network Down/Up status
local neticon = wibox.widget.imagebox(beautiful.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal, " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})

-- Textclock
local clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.fontfg(beautiful.font, beautiful.widget_fg_normal, stdout))
    end
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Setup wiboxes, tags and wallpaper for each screen
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

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
    -- left_sublayout:add(mylauncher)
    left_sublayout:add(s.mytaglist)
    left_sublayout:add(s.mypromptbox)

    -- Right widgets
    if s.index == 2 then
        mysystray.set_screen(s)
        right_sublayout:add(mysystray)
    end

    local bg_color_1 = "#44475a"
    local bg_color_2 = "#6272a4"

    function wrap_widget(widget, bg_color, left_margin, right_margin)
        widget = wibox.container.margin(widget, left_margin, right_margin)
        widget = wibox.container.background(widget, bg_color)
        return widget
    end

    -- Function to generate arrow separators
    local arrow = lain.util.separators.arrow_left

    right_sublayout:add(arrow("alpha", bg_color_1))
    right_sublayout:add(wrap_widget(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, bg_color_1, 3, 4))

    right_sublayout:add(arrow(bg_color_1, bg_color_2))
    right_sublayout:add(wrap_widget(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, bg_color_2, 4, 4))

    right_sublayout:add(arrow(bg_color_2, bg_color_1))
    right_sublayout:add(wrap_widget(wibox.widget { fsicon, fs.widget, layout = wibox.layout.align.horizontal }, bg_color_1, 3, 3))

    right_sublayout:add(arrow(bg_color_1, bg_color_2))
    right_sublayout:add(wrap_widget(wibox.widget { nil, neticon, net.widget, layout = wibox.layout.align.horizontal }, bg_color_2, 3, 3))

    right_sublayout:add(arrow(bg_color_2, bg_color_1))
    right_sublayout:add(wrap_widget(clock, bg_color_1, 4, 8))

    right_sublayout:add(arrow(bg_color_1, bg_color_2))
    right_sublayout:add(wrap_widget(s.mylayoutbox, bg_color_2, 0, 0))

    -- Putting everything together
    layout:set_left(left_sublayout)
    layout:set_middle(s.mytasklist)
    layout:set_right(right_sublayout)

    s.mywibox:set_widget(layout)
end)
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

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
