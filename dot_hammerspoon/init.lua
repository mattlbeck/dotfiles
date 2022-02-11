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
-- is not working.
hs.loadSpoon("AppBindings")
spoon.AppBindings:bind('Firefox', {
	{ meh, 'left', {'ctrl', 'shift' }, 'tab' },
	{ meh, 'right', {'ctrl'}, 'tab' },
	{ meh, 'down', {'cmd'}, 'l' },
	{ meh, 'x', {'cmd'}, 'left'},
	{ meh, 'd', {'cmd'}, 'right'},
	{ meh, 'forwarddelete', {'cmd'}, 'w'}
})
spoon.AppBindings:bind('Google Chrome', {
	{ meh, 'left', {'ctrl', 'shift' }, 'tab' },
	{ meh, 'right', {'ctrl'}, 'tab' },
	{ meh, 'down', {'cmd'}, 'l' },
	{ meh, 'x', {'cmd'}, 'left'},
	{ meh, 'd', {'cmd'}, 'right'},
	{ meh, 'forwarddelete', {'cmd'}, 'w'}
})

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

-- Move the focussed window to the next or previous screen
-- The direction of these switchers are reversed on my setup
hs.hotkey.bind(meh, "y", function() wm.moveToScreen(wm.getFocusedScreen():previous()) end) 
hs.hotkey.bind(meh, "l", function() wm.moveToScreen(wm.getFocusedScreen():next()) end)

-- Focus on the foremost window of a particular screen. Can be used with moveToScreen to
-- focus a window and then move it somewhere else
hs.hotkey.bind(meh, "i", function() wm.focusScreen(hs.screen.allScreens()[3]) end)
hs.hotkey.bind(meh, "e", function() wm.focusScreen(hs.screen.allScreens()[1]) end)
hs.hotkey.bind(meh, "n", function() wm.focusScreen(hs.screen.allScreens()[2]) end)

-- Resize the focussed window to cover left half, right half, or fill the screen
hs.hotkey.bind(meh, ",", wm.windowMaximize)
hs.hotkey.bind(meh, "h", function() wm.moveWindowToPosition(wm.screenPositions.left) end)
hs.hotkey.bind(meh, ".", function() wm.moveWindowToPosition(wm.screenPositions.right) end)

-- This screen switcher is a little slow and the filtering for a specific screen is not working properly
function focusedScreenSwitcher()
	return hs.window.switcher.new(hs.window.filter.new():setScreens(hs.window.focusedWindow():screen():id()))
end
hs.hotkey.bind(meh, "tab", function() focusedScreenSwitcher():next() end)
hs.alert.show("config reloaded")