hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local wm = require("window-management")

hyper =  {'ctrl', 'shift', 'alt', 'cmd'}
meh =  {'ctrl', 'shift', 'alt'} 

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

hs.hotkey.bind(hyper, "c", function()
	hs.execute("open -a Firefox https://www.youtube.com/watch?v=7NOSDKb0HlU")
end)

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

-- The direction of these switchers are reversed on my setup
hs.hotkey.bind(meh, "y", function() wm.moveToScreen(wm.getFocusedScreen():previous()) end) 
hs.hotkey.bind(meh, "l", function() wm.moveToScreen(wm.getFocusedScreen():next()) end)

hs.hotkey.bind(meh, "i", function() wm.focusScreen(hs.screen.allScreens()[3]) end)
hs.hotkey.bind(meh, "e", function() wm.focusScreen(hs.screen.allScreens()[1]) end)
hs.hotkey.bind(meh, "n", function() wm.focusScreen(hs.screen.allScreens()[2]) end)

hs.hotkey.bind(meh, ",", wm.windowMaximize)
hs.hotkey.bind(meh, "h", function() wm.moveWindowToPosition(wm.screenPositions.left) end)
hs.hotkey.bind(meh, ".", function() wm.moveWindowToPosition(wm.screenPositions.right) end)

function focusedScreenSwitcher()
	return hs.window.switcher.new(hs.window.filter.new():setScreens(hs.window.focusedWindow():screen():id()))
end
hs.hotkey.bind(meh, "tab", function() focusedScreenSwitcher():next() end)
hs.alert.show("config reloaded")