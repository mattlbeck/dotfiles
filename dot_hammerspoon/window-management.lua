-- curtosy of https://github.com/jhkuperus/dotfiles/blob/master/hammerspoon/window-management.lua
local This = {}

-- To easily layout windows on the screen, we use hs.grid to create a 4x4 grid.
-- If you want to use a more detailed grid, simply change its dimension here
local GRID_SIZE = 4
local HALF_GRID_SIZE = GRID_SIZE / 2

-- Set the grid size and add a few pixels of margin
-- Also, don't animate window changes... That's too slow
hs.grid.setGrid(GRID_SIZE .. 'x' .. GRID_SIZE)
hs.grid.setMargins({5, 5})
-- hs.window.animationDuration = 0

-- Defining screen positions
local screenPositions       = {}
screenPositions.left        = {x = 0,              y = 0,              w = HALF_GRID_SIZE, h = GRID_SIZE     }
screenPositions.right       = {x = HALF_GRID_SIZE, y = 0,              w = HALF_GRID_SIZE, h = GRID_SIZE     }
screenPositions.top         = {x = 0,              y = 0,              w = GRID_SIZE,      h = HALF_GRID_SIZE}
screenPositions.bottom      = {x = 0,              y = HALF_GRID_SIZE, w = GRID_SIZE,      h = HALF_GRID_SIZE}

screenPositions.topLeft     = {x = 0,              y = 0,              w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.topRight    = {x = HALF_GRID_SIZE, y = 0,              w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.bottomLeft  = {x = 0,              y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.bottomRight = {x = HALF_GRID_SIZE, y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}

This.screenPositions = screenPositions

-- This function will move either the specified or the focuesd
-- window to the requested screen position
function This.moveWindowToPosition(cell, window)
  if window == nil then
    window = hs.window.focusedWindow()
  end
  if window then
    local screen = window:screen()
    hs.grid.set(window, cell, screen)
  end
end

-- This function will move either the specified or the focused
-- window to the center of the sreen and let it fill up the
-- entire screen.
function This.windowMaximize(factor, window)
   if window == nil then
      window = hs.window.focusedWindow()
   end
   if window then
      window:maximize()
   end
end

--Predicate that checks if a window belongs to a screen
function This.isInScreen(screen, win)
	return win:screen() == screen
end

function This.focusScreen(screen)
	--Get windows within screen, ordered from front to back.
	--If no windows exist, bring focus to desktop. Otherwise, set focus on
	--front-most application window.
	local windows = hs.fnutils.filter(
		hs.window.orderedWindows(),
		hs.fnutils.partial(This.isInScreen, screen))
	local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
	windowToFocus:focus()

	-- Move mouse to center of screen
	local pt = hs.geometry.rectMidPoint(screen:fullFrame())
	hs.mouse.setAbsolutePosition(pt)
end

function This.getFocusedScreen()
	return hs.window.focusedWindow():screen()
end

function This.moveToScreen(screen)
	local win = hs.window.focusedWindow()
	win:moveToScreen(screen, false, true) 
end

-- ChatGPT generated this function
-- Function to get the window to the right or left of the current window
function This.focusWindow(direction)
    local win = hs.window.focusedWindow()  -- Get the currently focused window
    if not win then return end
	print("focusWindow")

    local screen = win:screen()  -- Get the screen of the current window
    local windows = hs.window.visibleWindows()  -- Get all visible windows
    local winFrame = win:frame()  -- Get the frame of the current window

    -- Sort windows by x position (left to right)
    table.sort(windows, function(a, b)
        return a:frame().x < b:frame().x
    end)

    -- Find the index of the current window
    local index
    for i, w in ipairs(windows) do
        if w:id() == win:id() then
            index = i
            break
        end
    end

    if not index then return end

    -- Focus the window to the left or right
    if direction == "right" and index < #windows then
        windows[index + 1]:focus()
    elseif direction == "left" and index > 1 then
        windows[index - 1]:focus()
    end
end


return This