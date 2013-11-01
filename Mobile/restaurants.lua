----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local json = require( "json" )
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

local d = 600

local bars = {}
local rests = {}
local chevs = {}

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local function goHome( event )

	if ( event.phase == "began" ) then
		storyboard.gotoScene( "landing" )
	end
end

local function selectRest( event )

	if ( event.phase == "began" ) then

		local opt =
		{
			params = 
			{
				name = rests[ event.target.rid ].text
			}
		}

		storyboard.gotoScene("restaurant", opt)
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	bars, rests, types, chevs = {}, {}, {}, {}

	margin = h / 4
	barH = h / 10
	spacing = h / 100

	xMar = w / 6

	header = display.newText("Restaurants", xMar / 3, margin / 2, "Segan", 22)
	header:setTextColor( black )
	header.alpha = 0

	for i = 1, 5, 1 do
		
		--create bars
		local bar = display.newRect(0, 0, w - spacing, barH)
		bar:setFillColor( 254, 254, 254 )
		bar.x , bar.y = w / 2, margin + (barH  + spacing / 2) * (i - 1)
		bar.alpha = 0
		bar.rid = i

		bars[ #bars + 1 ] = bar

		--create restaurant titles
		local rest = display.newText("loading...", xMar, bar.y - spacing * 3, "Segan", 18)
		rest:setTextColor( black )
		rest.alpha = 0

		rests[ #rests + 1 ] = rest

		--create restaurant titles
		local t = display.newText("loading type...", xMar, bar.y + spacing, "Segan", 14)
		t:setTextColor( black )
		t.alpha = 0

		types[ #types + 1 ] = t


		--create chevrons
		local c = display.newText(">", w - xMar, bar.y - spacing, "Segan", 18)
		c:setTextColor( black )
		c.alpha = 0

		chevs[ #chevs + 1 ] = c
	
	end

	local retW = 24

	ret = display.newImageRect( "back_icon.png", retW, retW )
	ret:setFillColor( 254, 254, 254 )
	ret.x, ret.y = spacing + retW , h - spacing - retW
	ret.alpha = 0

	ret:addEventListener( "touch", goHome )

	local data

	local function restaurantsCallback ( event )
		if ( event.isError ) then
			print( "Error occurred in callback." )
		else
			print ( "RESPONSE:" .. event.response )
			data = json.decode( event.response )

			for i = 1, 5, 1 do	
				rests[i].text = data[i]
				rests[i]:setReferencePoint( display.TopLeftReferencePoint )
				rests[i].x = xMar
			end	
		end
		return true;
	end

	local function getRestaurants ( event )
		local url = "http://unname00.w08.wh-2.com/api/restaurants"
		network.request( url, "GET", restaurantsCallback )
	end

	getRestaurants()
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	header.text = "Restaurants"

	transition.to( header, { time = d, delay = d, alpha = 1 })
	transition.to( ret, { time = d, delay = d, alpha = 1 })

	for i = 1, 5, 1 do

		transition.to( bars[i], { time = d, delay = d + (i - 1) * 200, alpha = 1 })
		transition.to( rests[i], { time = d, delay = d + (i - 1) * 200, alpha = 1 })
		transition.to( types[i], { time = d, delay = d + (i - 1) * 200, alpha = 1 })
		transition.to( chevs[i], { time = d, delay = d + (i - 1) * 200, alpha = 1 })

		bars[i]:addEventListener( "touch", selectRest )

	end

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	transition.to( header, { time = d, delay = d, alpha = 0 })
	transition.to( ret, { time = d, delay = d, alpha = 0 })

	for i = 1, 5, 1 do
		transition.to( bars[i], { time = d, delay = d + (i - 1) * 200, alpha = 0 })
		transition.to( rests[i], { time = d, delay = d + (i - 1) * 200, alpha = 0 })
		transition.to( types[i], { time = d, delay = d + (i - 1) * 200, alpha = 0 })
		transition.to( chevs[i], { time = d, delay = d + (i - 1) * 200, alpha = 0 })

		bars[i]:removeEventListener( "touch", selectRest )
	end 

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	header:removeSelf()

	for i = 1, 5, 1 do
		bars[i]:removeSelf()
		rests[i]:removeSelf()
		chevs[i]:removeSelf()
	end

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