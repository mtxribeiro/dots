-- MONITORS
hl.monitor({
	output = "auto",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- PROGRAMS
local terminal = "alacritty"
local menu = "rofi -show drun"

-- AUTOSTART
hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
end)

-- ENVIRONMENT
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- LOOK AND FEEL
hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,
		border_size = 0,
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0x44e0e0e0,
			color_inactive = 0xee000000,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- ANIMATIONS
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, damping = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 2.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 2.5, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.5, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 2.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2.5, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.5, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.5, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.5, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 5, bezier = "quick" })

-- LAYOUTS
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- MISC
hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

hl.config({
	render = {
		cm_auto_hdr = 0,
	},
})

hl.config({
	layers = {
		allow_new_top_layers_over_existing_fullscreen = true,
	},
})

-- INPUT
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "intl",
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "flat",
	},
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

-- KEYBINDINGS
local Mod = "SUPER"

hl.bind(Mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(Mod .. " + Q", hl.dsp.window.close())
hl.bind(
	Mod .. " + Shift + Escape",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(Mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(Mod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(Mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(Mod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(Mod .. " + Space", hl.dsp.exec_cmd(menu))

local directions = { H = "left", L = "right", K = "up", J = "down" }
for key, dir in pairs(directions) do
	hl.bind(Mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
	hl.bind(Mod .. " + Shift + " .. key, hl.dsp.window.move({ direction = dir }))
end

for i = 1, 10 do
	local key = i % 10
	hl.bind(Mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(Mod .. " + Shift + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(Mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(Mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(Mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(Mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- WINDOW RULES
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})
