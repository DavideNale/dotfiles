-- Hyprland config, Lua format (0.56+).
-- Migrated from hyprland.conf. See https://wiki.hypr.land/Configuring/Start/

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("HYPRCURSOR_THEME", "macOS")
hl.env("HYPRCURSOR_SIZE", "24")


------------------
---- MONITORS ----
------------------

hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0", scale = 1 })

-- Catch-all so any other/unknown display uses a mode it actually supports
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "alacritty"
local fileManager = "alacritty -e lf"
local menu        = "rofi -show drun"


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },

    input = {
        kb_layout  = "us,it",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:alt_space_toggle",
        kb_rules   = "",

        repeat_delay = 250,

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },

    general = {
        gaps_in     = 2,
        gaps_out    = 8,
        border_size = 2,

        col = {
            active_border   = "rgba(e6e6e6aa)",
            inactive_border = "rgba(303030aa)",
        },

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true, -- you probably want this
    },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",    enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6,  bezier = "default" })


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q",     hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",     hl.dsp.window.close())
hl.bind(mainMod .. " + M",     hl.dsp.exit())
hl.bind(mainMod .. " + E",     hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",     hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",     hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + F",     hl.dsp.window.fullscreen())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- screenshot
hl.bind("Print",                   hl.dsp.exec_cmd("env GSK_RENDERER=gl waypeek --capture-screen"))
hl.bind(mainMod .. " + Print",     hl.dsp.exec_cmd("env GSK_RENDERER=gl waypeek --capture-area"))


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- notification daemon
    hl.exec_cmd("dunst")

    -- background
    hl.exec_cmd("swaybg -i .wallpapers/foliage.jpg")

    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
    -- graphical-session.target refuses manual start; it must be pulled in as a
    -- dependency. hyprland-session.target BindsTo it, so starting this activates both.
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

-- graphical-session.target is StopWhenUnneeded=yes, so it stops on its own once
-- nothing wants it. Stopping this target is enough to tear down the whole session,
-- including everything PartOf= graphical-session.target (portals, gvfs).
hl.on("hyprland.shutdown", function()
    hl.exec_cmd("systemctl --user stop hyprland-session.target")
end)


-- # Nvidia
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("XDG_SESSION_TYPE", "wayland")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("WLR_NO_HARDWARE_CURSORS", "1")
