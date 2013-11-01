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

local white = { 255, 255, 255 }
local black = { 0, 0, 0 }

local icons, stats = {}, {}

local sPath = system.pathForFile( "settings.txt" )

local f = io.open( sPath, "r" )

local setArray = {}

for line in f:lines() do
	setArray[ #setArray + 1 ] = line
end

io.close(f)

local ret

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
	margin = h / 4
	barH = h / 10
	spacing = h / 100

	xMar = w / 6

	header = display.newText("Restaurant", xMar / 3.4, margin / 2, "Segan", 22, "left")
	header:setTextColor( black )
	header.alpha = 0

	local retW = h / 14

	local third = (w / 3)
	local paddingW = (third - retW) / 2

	local bottomY = h - (retW / 2) 

	ret = display.newImageRect( "back_white.png", retW, retW )
	ret:setFillColor( 254, 254, 254 )
	ret.x, ret.y = (w / 6), bottomY
	ret.alpha = 0

	retL = display.newRect(0, 0, paddingW, retW)
	retL:setFillColor( 254, 254, 254 )
	retL.x , retL.y = ret.x - (ret.width / 2) - (retL.width / 2), bottomY
	retL.alpha = 0

	retR = display.newRect(0, 0, paddingW, retW)
	retR:setFillColor( 254, 254, 254 )
	retR.x , retR.y = ret.x + (ret.width / 2) + (retR.width / 2), bottomY
	retR.alpha = 0

	meal = display.newImageRect( "meal_white.png", retW, retW )
	meal:setFillColor( 254, 254, 254 )
	meal.x, meal.y = (w / 2), bottomY
	meal.alpha = 0

	mealL = display.newRect(0, 0, paddingW, retW)
	mealL:setFillColor( 254, 254, 254 )
	mealL.x , mealL.y = meal.x - (meal.width / 2) - (mealL.width / 2), bottomY
	mealL.alpha = 0

	mealR = display.newRect(0, 0, paddingW, retW)
	mealR:setFillColor( 254, 254, 254 )
	mealR.x , mealR.y = meal.x + (meal.width / 2) + (mealR.width / 2), bottomY
	mealR.alpha = 0

	reset = display.newImageRect( "reset_white.png", retW, retW )
	reset:setFillColor( 254, 254, 254 )
	reset.x, reset.y = w - (w / 6), bottomY
	reset.alpha = 0

	resetL = display.newRect(0, 0, paddingW, retW)
	resetL:setFillColor( 254, 254, 254 )
	resetL.x , resetL.y = reset.x - (reset.width / 2) - (resetL.width / 2), bottomY
	resetL.alpha = 0

	resetR = display.newRect(0, 0, paddingW, retW)
	resetR:setFillColor( 254, 254, 254 )
	resetR.x , resetR.y = reset.x + (reset.width / 2) + (resetR.width / 2), bottomY
	resetR.alpha = 0	
	
	b = display.newRect(0, 0, w, retW * 1.5)
	b:setFillColor( 254, 254, 254 )
	b.x , b.y = b.width / 2, h - retW - (b.height / 2) - spacing
	b.alpha = 0	

	local icoW = 20

	local iNames = { "cal_icon.png", "fat_icon.png", "sod_icon.png", "chol_icon.png" }

	--add icons
	local iconNo = 4

	local values = {}

	values[1] = setArray[1]

	for i = 2, #setArray, 1 do
		values[i] = math.round(setArray[i] * values[1])
	end

	for i = 1, iconNo, 1 do
		local ico = display.newImageRect( iNames[i], icoW, icoW )
		ico.x, ico.y = i * (w / iconNo) - (w / iconNo / 2), b.y - (b.height / 4)
		ico:setFillColor( black )
		ico.alpha = 0

		icons[ #icons + 1 ] = ico

		local sta = display.newText(values[i], ico.x, b.y + (b.height / 8), "Segan", 18, "center")
		sta.alpha = 0
		sta:setTextColor( black )

		--annoying, have to reset the reference point to get the text to center
		sta:setReferencePoint( display.TopCenterReferencePoint )
		sta.x = ico.x

		stats[ #stats + 1 ] = sta

	end

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	print("called")
	header.text = event.params.name
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	transition.to( header, { time = 600, delay = 600, alpha = 1 })
	transition.to( ret, { time = 600, delay = 600, alpha = 1 })
	transition.to( meal, { time = 600, delay = 600, alpha = 1 })
	transition.to( reset, { time = 600, delay = 600, alpha = 1 })

	transition.to( retL, { time = 600, delay = 600, alpha = 1 })
	transition.to( mealL, { time = 600, delay = 600, alpha = 1 })
	transition.to( resetL, { time = 600, delay = 600, alpha = 1 })

	transition.to( retR, { time = 600, delay = 600, alpha = 1 })
	transition.to( mealR, { time = 600, delay = 600, alpha = 1 })
	transition.to( resetR, { time = 600, delay = 600, alpha = 1 })

	transition.to( b, { time = 600, delay = 600, alpha = 1 })	

	for i = 1, #icons, 1 do
		transition.to( icons[i], { time = 600, delay = 600, alpha = 1 })		
		transition.to( stats[i], { time = 600, delay = 800, alpha = 1 })	
	end

	local function returnToRests( event )
		if ( event.phase == "began" ) then
			storyboard.gotoScene( "restaurants" )
		end
	end

	ret:addEventListener("touch", returnToRests )
	retL:addEventListener("touch", returnToRests )
	retR:addEventListener("touch", returnToRests )	

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	transition.to( header, { time = 600, delay = 600, alpha = 0 })
	transition.to( ret, { time = 600, delay = 600, alpha = 0 })
	transition.to( meal, { time = 600, delay = 600, alpha = 0 })
	transition.to( reset, { time = 600, delay = 600, alpha = 0 })

	transition.to( retL, { time = 600, delay = 600, alpha = 0 })
	transition.to( mealL, { time = 600, delay = 600, alpha = 0 })
	transition.to( resetL, { time = 600, delay = 600, alpha = 0 })

	transition.to( retR, { time = 600, delay = 600, alpha = 0 })
	transition.to( mealR, { time = 600, delay = 600, alpha = 0 })
	transition.to( resetR, { time = 600, delay = 600, alpha = 0 })

	transition.to( b, { time = 600, delay = 600, alpha = 0 })

	for i = 1, #icons, 1 do
		transition.to( icons[i], { time = 600, delay = 600, alpha = 0 })		
		transition.to( stats[i], { time = 600, delay = 800, alpha = 0 })	
	end

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

	header:removeSelf()
	ret:removeSelf()
	
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