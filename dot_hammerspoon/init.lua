hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local wm = require("window-management")

-- These modifier combos are the main ones used for most
-- of the hotkey binding
hyper =  {'ctrl', 'shift', 'alt', 'cmd'}
meh =  {'ctrl', 'shift', 'alt'} 
-- map hyper or meh hotkeys for certain apps
-- it is often easier to do this here than 
-- configure each app individually
-- An exception is VS Code, where this mapping
-- is not working. Instead I have directly applied this keybinding in
-- vs code's settings
hs.loadSpoon("AppBindings")
spoon.AppBindings:bind('Firefox', {
	{ hyper, 'left', {'ctrl', 'shift' }, 'tab' },
	{ hyper, 'right', {'ctrl'}, 'tab' },
})
spoon.AppBindings:bind('Google Chrome', {
	{ hyper, 'left', {'ctrl', 'shift' }, 'tab' },
	{ hyper, 'right', {'ctrl'}, 'tab' },
})
-- spoon.AppBindings:bind('Code', {
--	{ hyper, 'left', {'cmd', 'alt'}, 'left'},
--	{ hyper, 'right', {'cmd', 'alt'}, 'right'}
-- })

-- One-key Chill mode!
-- Opens the youtube Chillhop stream with one key
hs.hotkey.bind(hyper, "c", function()
	hs.execute("open -a Firefox https://www.youtube.com/watch?v=7NOSDKb0HlU")
end)

-- hotkeys for app launching/focusing
function mehApp(key, app)
	hs.hotkey.bind(meh, key, function() 
		hs.application.launchOrFocus(app)
	end)
end

mehApp("1", "Zulip")
mehApp("2", "Visual Studio Code")
mehApp("3", "Google Chrome")
mehApp("4", "Firefox")
mehApp("5", "Hyper")

-- hammerspoon window switcher
-- set up your windowfilter
function visible_windows()
	switcher = hs.window.switcher.new()
	return switcher
end
hs.hotkey.bind(hyper, 'tab', function() switcher:next() end) -- switch to next window

hs.loadSpoon("MiroWindowsManager")  

hs.window.animationDuration = 0.3
-- spoon.MiroWindowsManager:bindHotkeys({
--   up = {hyper, "up"},
--   right = {hyper, "right"},
--   down = {hyper, "down"},
--   left = {hyper, "left"},
--   fullscreen = {hyper, "f"},
--   nextscreen = {hyper, "n"}
-- })

-- This screen switcher is a little slow and the filtering for a specific screen is not working properly
-- function focusedScreenSwitcher()
-- 	return hs.window.switcher.new(hs.window.filter.new():setScreens(hs.window.focusedWindow():screen():id()))
-- end
-- hs.hotkey.bind(meh, "tab", function() focusedScreenSwitcher():next() end)

-- Bind hotkeys to move focus to the immediate left or right window
hs.hotkey.bind(meh, "right", function()
	wm.focusWindow("right")
end)

hs.hotkey.bind(meh, "left", function()
    wm.focusWindow("left")
end)

hs.alert.show("config reloaded")