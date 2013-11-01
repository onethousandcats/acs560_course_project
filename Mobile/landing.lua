----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------
local w = display.viewableContentWidth
local h = display.viewableContentHeight

local black = { 0, 0, 0 }

function removeAllListeners(obj)
  obj._functionListeners = nil
  obj._tableListeners = nil
end


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	title = display.newText("Calor", 0, 0, "Segan", 50)
	title:setTextColor( black )
	title.x, title.y = w / 2, h * .2

	local logoWidth = 50

	logo = display.newImageRect( "logo.png", logoWidth, logoWidth * 1.5 )
	logo.x, logo.y, logo.alpha = w / 2, h * .36, 1
	logo:setFillColor( black )

	add = display.newText("+", 0, 0, "Segan", 100)
	add:setTextColor( black )
	add.x, add.y = w / 2, h * .7

	local settingWidth = 20

	settings = display.newImageRect( "settings.png", settingWidth, settingWidth )
	settings.x, settings.y = w * .90, h * .94
	settings:setFillColor( black )

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------

	local function goToRestauarants ( event )
		if ( event.phase == "began" ) then
			storyboard.gotoScene( "restaurants" )
		end
	end

	add:addEventListener( "touch", goToRestauarants )

	local function gotoSettings ( event )
		if ( event.phase == "began" ) then
			storyboard.gotoScene( "settings" )
			return true;
		end
	end

	settings:addEventListener( "touch", gotoSettings )

	transition.to( title, { time = 600, delay = 0, alpha = 1 })
	transition.to( logo, { time = 600, delay = 0, alpha = 1 })
	transition.to( add, { time = 600, delay = 0, alpha = 1 })
	transition.to( settings, { time = 600, delay = 0, alpha = 1 })

	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	transition.to( title, { time = 600, delay = 0, alpha = 0 })
	transition.to( logo, { time = 600, delay = 0, alpha = 0 })
	transition.to( add, { time = 600, delay = 0, alpha = 0 })
	transition.to( settings, { time = 600, delay = 0, alpha = 0 })

	removeAllListeners( add )
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	title:removeSelf()
	logo:removeSelf()
	add:removeSelf()
	settings:removeSelf()

end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene