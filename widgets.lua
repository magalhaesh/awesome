-- ===================================================================
-- Functions and utilities for setting up widgets
-- ===================================================================
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local lain = require("lain")

-- Module table.
local widgets = {}

local widget_table = {}

-- Facilitates text customization.
local markup = lain.util.markup

-- Function to generate arrow separators.
local arrow = lain.util.separators.arrow_left

-- MEM
local memicon = wibox.widget.imagebox(beautiful.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal, " " .. mem_now.used .. "MB "))
    end
})

widget_table.mem = { icon = memicon, widget = mem.widget }

-- CPU
local cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal ," " .. cpu_now.usage .. "% "))
    end
})

widget_table.cpu = { icon = cpuicon, widget = cpu.widget }

-- System Temperature
local tempicon = wibox.widget.imagebox(beautiful.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal, " " .. coretemp_now .. "°C "))
    end
})

widget_table.temp = { icon = tempicon, widget = temp.widget }

-- Space available on filesystem
local fsicon = wibox.widget.imagebox(beautiful.widget_hdd)
local fs = lain.widget.fs({
    options  = "--exclude-type=tmpfs",
    notification_preset = { fg = beautiful.fg_normal, bg = beautiful.bg_normal, font = "Hack 8" },
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal, " " .. fs_now.available_gb .. "GB "))
    end
})

widget_table.fs = { icon = fsicon, widget = fs.widget }

-- Network Down/Up status
local neticon = wibox.widget.imagebox(beautiful.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.widget_fg_normal, " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})

widget_table.net = { icon = neticon, widget = net.widget }

-- Textclock
local clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.fontfg(beautiful.font, beautiful.widget_fg_normal, stdout))
    end
)

widget_table.clock = { icon = nil, widget = clock }

-- Wraps widgets into a "cute" box with margins and backgrounds. The must be a
-- better way of doing this. TODO refactor
function widgets.wrap_widget(icon, widget, bg_color, left_margin, right_margin)
    if (icon ~= nil) then 
        widget = wibox.widget { 
            icon,
            widget,
            layout = wibox.layout.align.horizontal 
        }
    end
    widget = wibox.container.margin(widget, left_margin, right_margin)
    widget = wibox.container.background(widget, bg_color)
    return widget
end

-- Get widget with configurable background and margins.
function widgets.get_widget(widget_name, bg_color, left_margin, right_margin)
    return widgets.wrap_widget(
        widget_table[widget_name].icon,
        widget_table[widget_name].widget,
        bg_color,
        left_margin,
        right_margin
    )
end

-- Gets a left arrow. What a shock.
function widgets.get_left_arrow(background, tip)
    return arrow(background, tip)
end

return widgets
