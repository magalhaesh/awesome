-- ===================================================================
-- Functions and utilities for setting up awful rules
-- ===================================================================
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local rules = {}

function rules.create(client_keys, client_buttons)
    -- Rules for all clients.
    return {
        { 
            rule = { },
            properties = { 
                shape = gears.shape.transform(gears.shape.rounded_rect),
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = client_keys,
                buttons = client_buttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                size_hints_honor = false
            }
        },

        -- Floating clients.
        { 
            rule_any = {
                instance = {
                    "copyq", -- Includes session name in class.
                },
                class = {
                    "arandr", -- Xorg gui configuration
                    "gpick", -- Color picker
                    "sxiv", -- Image viewer
                    "vimiv", -- Image viewer
                    "pinentry", -- gpg
                },
                name = {
                    "Event Tester", -- xev
                },
                role = {
                    "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = {
                floating = true,
                placement = awful.placement.centered
            }
        }
    }
end

return rules
