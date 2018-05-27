-- Imports
local awful         = require("awful")
local naughty		= require("naughty")

-- Private constants


-- Private functions
local function alert(text)
	naughty.notify({
		text = text,
		position = "top_middle",
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

-- Exports
local API = {
	alert = alert,
	capture_fullscreen = capture_fullscreen,
	capture_region = capture_region,
	capture_window = capture_window,
	pick_color = pick_color,
	run_once = run_once,
}
return API