-- ===================================================================
-- Sets up awful keys and buttons to be plugged on rc.lua
-- ===================================================================
local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local helpers = require("helpers")
local terminal = helpers.default_apps.terminal

-- Module table.
local keys = {}

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
modkey = "Mod4"

-- Next and prev buttons for Logitech G502
prevbutton = 8
nextbutton = 9

-- Global keybindings; Use with root keys to make them work anywhere.
keys.global_keys = gears.table.join(
    awful.key({ modkey,           }, "q",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    awful.key({ modkey,           }, "w", function () awful.util.spawn("rofi -show window") end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    -- Rua lua code
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    -- Calls Menubar, which shows freedesktop menu items
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

    -- Function Keys
    awful.key({                   }, "XF86AudioMute",    function () awful.util.spawn("amixer -D pulse set Master toggle") awful.util.spawn("amixer set Speaker toggle") end),
    awful.key({                   }, "XF86AudioLowerVolume",    function () awful.util.spawn("pulsemixer --change-volume -1") end),
    awful.key({                   }, "XF86AudioRaiseVolume",    function () awful.util.spawn("pulsemixer --change-volume +1") end),
    awful.key({                   }, "XF86AudioPlay",     function () awful.util.spawn("playerctl play-pause --player=spotify") end),
    awful.key({                   }, "XF86AudioStop",     function () awful.util.spawn("playerctl stop --player=spotify") end),
    awful.key({                   }, "XF86AudioPrev",     function () awful.util.spawn("playerctl previous --player=spotify") end),
    awful.key({                   }, "XF86AudioNext",     function () awful.util.spawn("playerctl next --player=spotify") end),
    awful.key({                   }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 5") end),
    awful.key({                   }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 5") end),

    -- Custom
    awful.key({ modkey,           }, "F1",    function () awful.util.spawn("amixer -D pulse set Master toggle") awful.util.spawn("amixer set Speaker toggle") end),
    awful.key({ modkey,           }, "F2",    function () awful.util.spawn("pulsemixer --change-volume -5")  awful.util.spawn("amixer set Speaker 5%-") end),
    awful.key({ modkey,           }, "F3",    function () awful.util.spawn("pulsemixer --change-volume +5") awful.util.spawn("amixer set Speaker 5%+") end),
    awful.key({ modkey,           }, "F5",    function () awful.util.spawn("cmus-remote -u") end),
    awful.key({ modkey,           }, "F6",    function () awful.util.spawn("cmus-remote -s") end),
    awful.key({ modkey,           }, "F7",    function () awful.util.spawn("cmus-remote -r") end),
    awful.key({ modkey, "Shift"   }, "F7",    function () awful.util.spawn("cmus-remote -k -15s") end),
    awful.key({ modkey,           }, "F8",    function () awful.util.spawn("cmus-remote -n") end),
    awful.key({ modkey, "Shift"   }, "F8",    function () awful.util.spawn("cmus-remote -k +15s") end),
    awful.key({ modkey,           }, "F9",    function () awful.util.spawn("cmus-remote -S") end),
    awful.key({ modkey,           }, "F12",   function () awful.util.spawn("xscreensaver-command -lock") end),

    awful.key({ modkey,           }, "a",     function () awful.util.spawn("playerctl previous --player=spotify") end),
    awful.key({ modkey,           }, "s",     function () awful.util.spawn("playerctl next --player=spotify") end),
    awful.key({ modkey,           }, "d",     function () awful.util.spawn("playerctl play-pause --player=spotify") end),
    awful.key({ modkey,           }, "i",     function () awful.util.spawn("xcalib -i -a") end),

    -- Rename tag
    awful.key({ modkey, "Shift"   }, "Tab", function () lain.util.rename_tag(mypromptbox) end)
)

-- Bind all key numbers to tags.
-- Be careful: keycodes are used to make this work on any keyboard layout.
-- This should map to the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keys.global_keys = gears.table.join(keys.global_keys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Keys for clients; Use with awful rule properties to set up client keys.
keys.client_keys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Buttons for desktop; Sets up clicks outside clients.
keys.desktop_buttons = gears.table.join(
    -- Right click opens menu
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, nextbutton, awful.tag.viewnext),
    awful.button({ }, prevbutton, awful.tag.viewprev)
)

-- Buttons for clients; Use with awful rule properties to set up client clicks.
keys.client_buttons = gears.table.join(
    -- Raise & focus client on click
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    -- Move client on meta + click
    awful.button({ modkey }, 1, awful.mouse.client.move),
    -- Resize client on meta + right click
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Buttons for taglist widget.
keys.taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, nextbutton, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, prevbutton, function(t) awful.tag.viewprev(t.screen) end)
)

-- Buttons for tasklist widget.
keys.tasklist_buttons = gears.table.join(
    -- Minimize/Un-minimize on click
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    -- Shows menu with all clients
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({ theme = { width = 250 } })
            end
        end
    end),
    -- Focus next client
    awful.button({ }, nextbutton, function ()
        awful.client.focus.byidx(1)
    end),
    -- Focus previous client
    awful.button({ }, prevbutton, function ()
        awful.client.focus.byidx(-1)
    end)
)

return keys
