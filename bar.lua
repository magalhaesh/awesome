-- ===================================================================
-- Sets up custom bar with tags, tasklist and widgets
-- ===================================================================
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("widgets")
local beautiful = require("beautiful")

local bar = {}

-- Create systray widget (holds systray icons for apps who provide them).
local mysystray = wibox.widget.systray()

-- Creates and configures custom wibar.
function bar.setup(s, keys)
    -- Create a promptbox for each screen.
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which
    -- layout we're using.
    s.mylayoutbox = awful.widget.layoutbox(s)

    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget.
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, keys.taglist_buttons)

    -- Create a tasklist widget.
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, keys.tasklist_buttons)

    local left_sublayout = wibox.layout.fixed.horizontal()
    local right_sublayout = wibox.layout.fixed.horizontal()

    -- Left widgets.
    left_sublayout:add(s.mytaglist)
    left_sublayout:add(s.mypromptbox)

    -- Right widgets.
    if s.index == 2 then
        mysystray.set_screen(s)
        right_sublayout:add(mysystray)
    end

    local bg_color_1 = beautiful.bg_normal
    local bg_color_2 = beautiful.bg_focus

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

    -- Putting everything together in one box.
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_sublayout)
    layout:set_middle(s.mytasklist)
    layout:set_right(right_sublayout)

    -- Create the wibar.
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18 })
    s.mywibox:set_widget(layout)
end

return bar
