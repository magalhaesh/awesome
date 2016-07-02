--[[
                                      
     Multicolor Awesome WM config 2.0 
     github.com/copycat-killer        
                                      
--]]


theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/glazunov"
theme.wallpaper                     = theme.confdir .. "/background.png"

theme.font                          = "Hack Bold 8"
--theme.taglist_font                =
theme.bg_normal                     = "#282a36"
theme.bg_focus                      = "#9474d4"
theme.bg_urgent                     = "#5236C4"
theme.fg_normal                     = "#aaaaaa"
theme.fg_focus                      = "#000000"
theme.fg_urgent                     = "#aaaaaa"
theme.bg_minimize                   = "#000000"
theme.fg_minimize                   = "#ffffff"
theme.fg_black                      = "#424242"
theme.fg_red                        = "#ce5666"
theme.fg_green                      = "#80a673"
theme.fg_yellow                     = "#ffaf5f"
theme.fg_blue                       = "#7788af"
theme.fg_magenta                    = "#94738c"
theme.fg_cyan                       = "#778baf"
theme.fg_white                      = "#aaaaaa"
theme.fg_blu                        = "#8ebdde"
theme.border_width                  = "2"
theme.border_normal                 = "#1c2022"
theme.border_focus                  = "#8e71b7"
theme.border_marked                 = "#3ca4d8"
theme.menu_width                    = "110"
theme.menu_border_width             = "0"
theme.menu_fg_normal                = "#8e71b7"
theme.menu_fg_focus                 = "#f635a5"

theme.submenu_icon                  = theme.confdir .. "/icons/submenu.png"
theme.widget_temp                   = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                 = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                    = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                = theme.confdir .. "/icons/dish.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_mem                    = theme.confdir .. "/icons/mem.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_note                   = theme.confdir .. "/icons/note.png"
theme.widget_note_on                = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown                = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                  = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                   = theme.confdir .. "/icons/mail.png"
theme.widget_batt                   = theme.confdir .. "/icons/bat.png"
theme.widget_clock                  = theme.confdir .. "/icons/clock.png"
theme.widget_vol                    = theme.confdir .. "/icons/spkr.png"

theme.taglist_squares_sel           = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel         = theme.confdir .. "/icons/square_b.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- theme.layout_tile                   = theme.confdir .. "/icons/tile.png"
-- theme.layout_tilegaps               = theme.confdir .. "/icons/tilegaps.png"
-- theme.layout_tileleft               = theme.confdir .. "/icons/tileleft.png"
-- theme.layout_tilebottom             = theme.confdir .. "/icons/tilebottom.png"
-- theme.layout_tiletop                = theme.confdir .. "/icons/tiletop.png"
-- theme.layout_fairv                  = theme.confdir .. "/icons/fairv.png"
-- theme.layout_fairh                  = theme.confdir .. "/icons/fairh.png"
-- theme.layout_spiral                 = theme.confdir .. "/icons/spiral.png"
-- theme.layout_dwindle                = theme.confdir .. "/icons/dwindle.png"
-- theme.layout_max                    = theme.confdir .. "/icons/max.png"
-- theme.layout_fullscreen             = theme.confdir .. "/icons/fullscreen.png"
-- theme.layout_magnifier              = theme.confdir .. "/icons/magnifier.png"
-- theme.layout_floating               = theme.confdir .. "/icons/floating.png"

theme.useless_gap_width                         = 10

theme.layout_txt_tile               = "[t]"
theme.layout_txt_tileleft           = "[l]"
theme.layout_txt_tilebottom         = "[b]"
theme.layout_txt_tiletop            = "[tt]"
theme.layout_txt_fairv              = "[fv]"
theme.layout_txt_fairh              = "[fh]"
theme.layout_txt_spiral             = "[s]"
theme.layout_txt_dwindle            = "[d]"
theme.layout_txt_max                = "[m]"
theme.layout_txt_fullscreen         = "[F]"
theme.layout_txt_magnifier          = "[M]"
theme.layout_txt_floating           = "[*]"
theme.layout_txt_cascade            = "[cascade]"
theme.layout_txt_cascadetile        = "[cascadetile]"
theme.layout_txt_centerwork         = "[centerwork]"
theme.layout_txt_termfair           = "[termfair]"
theme.layout_txt_centerfair         = "[centerfair]"
theme.layout_txt_uselessfair        = "[uf]"
theme.layout_txt_uselessfairh       = "[ufh]"
theme.layout_txt_uselesspiral       = "[us]"
theme.layout_txt_uselessdwindle     = "[ud]"
theme.layout_txt_uselesstile        = "[ut]"
theme.layout_txt_uselesstileleft    = "[utl]"
theme.layout_txt_uselesstiletop     = "[utt]"
theme.layout_txt_uselesstilebottom  = "[utb]"

return theme
