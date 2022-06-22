-- ===================================================================
-- Helper functions and tables that don't fit anywhere else.
-- ===================================================================
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Module table.
local helpers = {}

helpers.default_apps = {
    terminal = "kitty",
    editor = os.getenv("EDITOR") or "vim"
}

-- Sets a wallpaper on each screen.
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

-- Activate screen locker.
function helpers.lock_screen()
    awful.util.spawn("xscreensaver-command -lock")
end

-- Toggle system volume mute.
function helpers.toggle_mute()
    awful.util.spawn("pulsemixer --toggle-mute")
end

-- Change system volume.
-- @param change_percentage_text Amount to change, preceded by +/- (e.g. "+5")
function helpers.change_volume(change_percentage_text)
    awful.util.spawn("pulsemixer --change-volume " .. change_percentage_text)
end

-- Play/pause music player.
function helpers.song_toggle_play()
    awful.util.spawn("playerctl play-pause --player=spotify")
end

-- Go to previous song in music player.
function helpers.song_previous()
    awful.util.spawn("playerctl previous --player=spotify")
end

-- Go to next song in music player.
function helpers.song_next()
    awful.util.spawn("playerctl next --player=spotify")
end

-- Go to next song in music player.
function helpers.song_next()
    awful.util.spawn("playerctl next --player=spotify")
end

-- Toggle desk light on/off.
function helpers.toggle_desk_light()
    awful.util.spawn_with_shell(
        "curl -X POST \"https://api.lifx.com/v1/lights/label:PC/toggle\" -H \"Authorization: Bearer $(<~/.lifxtoken)\""
    )
end

return helpers
