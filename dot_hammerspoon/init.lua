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

function getFocusedScreen()
	return hs.window.focusedWindow():screen()
end

function moveToScreen(screen)
	local win = hs.window.focusedWindow()
	win:moveToScreen(screen, false, true) 
end

-- The direction of these switchers are reversed on my setup
hs.hotkey.bind(meh, "y", function() moveToScreen(getFocusedScreen():previous()) end) 
hs.hotkey.bind(meh, "l", function() moveToScreen(getFocusedScreen():next()) end)

--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
	return win:screen() == screen
end

function focusScreen(screen)
	--Get windows within screen, ordered from front to back.
	--If no windows exist, bring focus to desktop. Otherwise, set focus on
	--front-most application window.
	local windows = hs.fnutils.filter(
		hs.window.orderedWindows(),
		hs.fnutils.partial(isInScreen, screen))
	local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
	windowToFocus:focus()

	-- Move mouse to center of screen
	local pt = hs.geometry.rectMidPoint(screen:fullFrame())
	hs.mouse.setAbsolutePosition(pt)
end

hs.hotkey.bind(meh, "i", function() focusScreen(getFocusedScreen():previous()) end)
hs.hotkey.bind(meh, "n", function() focusScreen(getFocusedScreen():next()) end)

hs.hotkey.bind(meh, ",", wm.windowMaximize)
hs.hotkey.bind(meh, "h", function() wm.moveWindowToPosition(wm.screenPositions.left) end)
hs.hotkey.bind(meh, ".", function() wm.moveWindowToPosition(wm.screenPositions.right) end)

function focusedScreenSwitcher()
	return hs.window.switcher.new(hs.window.filter.new():setScreens(hs.window.focusedWindow():screen():id()))
end
hs.hotkey.bind(meh, "tab", function() focusedScreenSwitcher():next() end)
hs.alert.show("config reloaded")