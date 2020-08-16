-- ===================================================================
-- Helper functions that don't fit anywhere else.
-- ===================================================================
local gears = require("gears")
local beautiful = require("beautiful")

local helpers = {}

-- Function for setting wallpaper on each screen.
function helpers.set_wallpaper(s)
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

return helpers
