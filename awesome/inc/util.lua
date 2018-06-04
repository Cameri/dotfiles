-- Imports
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

-- Private constants


-- Private functions
local function confirm_action(name, func)
	-- awful.screen.focused().mywibox:set_bg(beautiful.bg_urgent)
	-- awful.screen.focused().mywibox:set_fg(beautiful.fg_urgent)
	awful.prompt.run {
				prompt = name .. " [y/N] ",
				textbox = awful.screen.focused().mypromptbox_conf.widget,
				exe_callback = function (t)
					 if string.lower(t) == 'y' then
							func()
					 end
				end,
				history_path = nil,
				done_callback = function ()
					--  awful.screen.focused().mywibox:set_bg(
					-- 		beautiful.screen_highlight_bg_active)
					--  awful.screen.focused().mywibox:set_fg(
					-- 		beautiful.screen_highlight_fg_active)
				end
	}
end

local function alert(text)
	naughty.notify({
		text = text,
		position = "top_middle",
		timeout = 3
	})
end

local function notify(text)
	naughty.notify({
		text = text,
		position = "top_right",
		timeout = 3
	})
end

local function run_once(cmd_arr)
	local findme, firstspace
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

--
local function capture_fullscreen()
	local dest = os.getenv("SCREENSHOTS_PATH") or "~/Pictures"
	awful.spawn(string.format("escrotum -e 'mv $f %s'", dest))
end

local function capture_region()
	local dest = os.getenv("SCREENSHOTS_PATH") or "~/Pictures"
	awful.spawn(string.format("escrotum -s -e 'mv $f %s'", dest))
end

local function capture_window()
	local dest = os.getenv("SCREENSHOTS_PATH") or "~/Pictures"
	awful.spawn.with_shell(string.format("escrotum -u -e 'mv $f %s && '", dest))
end

local function pick_color()
	awful.spawn.with_shell("colorpicker --short --one-shot | xsel -b")
end

local function lock_screen()
	awful.spawn("gnome-screensaver-command -l")
end

local function g13_load_config(binding)
	awful.spawn.with_shell("cat $HOME/.config/g13/bindings/" .. binding .. ".bind > /tmp/g13d-in")
	notify("Key bindings " .. binding .. " loaded in G13 Advanced Gameboard")
end

local function reboot()
	confirm_action("Reboot?", function ()
		awful.spawn("reboot")
	end)
end

local function poweroff()
	confirm_action("Power off?", function ()
		awful.spawn("poweroff")
	end)
end

-- Exports
local API = {
	alert = alert,
	capture_fullscreen = capture_fullscreen,
	capture_region = capture_region,
	capture_window = capture_window,
	pick_color = pick_color,
	g13_load_config = g13_load_config,
	run_once = run_once,
	lock_screen = lock_screen,
	log_off,
	reboot = reboot,
	poweroff = poweroff
}
return API