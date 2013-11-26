----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local w = display.viewableContentWidth
local h = display.viewableContentHeight

-- get stored settings
local sPath = system.pathForFile( "settings.txt" )

local f = io.open( sPath, "r" )

local setArray = {}

for line in f:lines() do
	setArray[ #setArray + 1 ] = line
end

io.close(f)
--
numOfSteps = 100;
maxVals = { 100, 1000, 300 } -- fat, sodium, cholesterol
currentLowVals = { setArray[2], setArray[4], setArray[6] }
currentHighVals = { setArray[3], setArray[5], setArray[7] }

function removeAllListeners(obj)
  obj._functionListeners = nil
  obj._tableListeners = nil
end

local textViewsLow = {}
local textViewsHigh = {}
local icons = {}
local bars = {}
local pointersLow = {}
local pointersHigh = {}

local margin = w / 8

local barMin, barW
----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	icoW = 30

	setTitle = display.newText("Settings", 0, 0, "Segan", 32)
	setTitle:setTextColor( black )
	setTitle.x, setTitle.y = margin * 2.2, margin * 2
	setTitle.alpha = 0

	cals = display.newText(setArray[1], 0, 0, "Segan", 34)
	cals:setTextColor( black )
	cals.x, cals.y =  w - margin * 4, margin * 3 + icoW * 1.1 + margin
	cals.alpha = 0
	cals.name = "cals"
	
	local iNames = { "cal_icon.png", "fat_icon.png", "sod_icon.png", "chol_icon.png" }
	local currentValueIndex = 1
	for i = 1, 4, 1 do
		
		local ico = display.newImageRect( iNames[i], icoW, icoW )
		ico.x, ico.y = margin * 1.4, margin * 3 + ((icoW + margin) * i) 
		ico:setFillColor( black )
		ico.alpha = 0

		icons[ #icons + 1 ] = ico

		barW = w / 2
		barMin = (ico.x + w / 2.5) - (barW / 2)
		
		if i > 1 then
			local bar = display.newRect( 0, 0, barW, 1 )
			bar.x, bar.y = ico.x + w / 2.5, ico.y
			bar.alpha = 0
			bar:setFillColor( black )

			bars[ #bars + 1 ] = bar

			local pointerHigh = display.newCircle( barMin + barW * currentHighVals[currentValueIndex], bar.y, 6 )			
			pointerHigh.alpha = 0
			pointerHigh:setFillColor( black )
			local pointerLow = display.newCircle( barMin + barW * currentLowVals[currentValueIndex], bar.y, 6 )			
			pointerLow.alpha = 0
			pointerLow:setFillColor( black )
			pointersLow[ #pointersLow + 1 ] = pointerLow
			pointersHigh[ #pointersHigh + 1] = pointerHigh	
			valueLow, valueHigh = display.newText("0", 0, 0, "Segan", 20), display.newText(maxVals[currentValueIndex], 0, 0, "Segan", 20)
			valueLow:setTextColor( black )
			valueHigh:setTextColor( black )
			valueLow.x, valueHigh.x, valueLow.y, valueHigh.y =  barMin - 15, barMin + barW + 30, bar.y, bar.y
			valueLow.alpha, valueHigh.alpha = 0, 0
			textViewsLow[ #textViewsLow + 1] = valueLow;
			textViewsHigh[ #textViewsHigh + 1] = valueHigh;
			currentValueIndex = currentValueIndex + 1;
		end
		updateTextViews();
	end

	pointersHigh[1].name = "fathigh"
	pointersLow[1].name = "fatlow";
	pointersHigh[2].name = "sodhigh"
	pointersLow[2].name = "sodlow"
	pointersHigh[3].name = "cholhigh"
	pointersLow[3].name = "chollow"

	save = display.newImageRect( "save_icon.png", icoW * .8, icoW * .8 )
	save.x, save.y = margin * 2.4, h * .9
	save:setFillColor( black )
	save.alpha = 0
	save.saveSettings = true

	cancel = display.newImageRect( "cancel_icon.png", icoW * .8, icoW * .8 )
	cancel.x, cancel.y = w - margin * 2.4, h * .9
	cancel:setFillColor( black )
	cancel.alpha = 0
	cancel.saveSettings = false

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
end
function updateTextViews()
	for i = 1, #textViewsLow, 1 do
		textViewsLow[i].text = round(currentLowVals[i] * maxVals[i], maxVals[i] / numOfSteps)
		textViewsHigh[i].text = round(currentHighVals[i] * maxVals[i], maxVals[i] / numOfSteps)
	end
end
-- Round 'num' to nearest N*'step' (step can be any positive number, i.e. 22.5)
	--
function round( v, step )
    step= step or 1
    assert( step > 0 )
    return math.floor( (v+step/2) / step ) * step
end
function returnToLanding ( event )
	if ( event.phase == "began" ) then
		if event.target.saveSettings == true then
			print("settings have been saved")

			setArray[1] = cals.text
			for i = 1, #currentLowVals, 1 do
				setArray[i * 2] = currentLowVals[i]
				setArray[i * 2 + 1] = currentHighVals[i]
			end

			local f = io.open( sPath, "w" )
			for _,i in ipairs( setArray ) do
				f:write( i .. "\n")
			end
			io.close( f )
		end

		removeAllListeners( save )
		removeAllListeners( cancel )

		storyboard.gotoScene( "landing" )
		return true
	end
end

function sceneTouch ( event )

	local t = event.target
	if ( t.name == "cals" ) then
		if event.phase == "began" then
			print ( "cals touched" )

			t.isFocus = true;

			t.y0 = event.y - t.y
		elseif t.isFocus then
			if event.phase == "moved" then
				deltaY = event.y - t.y0 - t.y
				print (deltaY)
				cals.text = setArray[1] - deltaY

			elseif event.phase == "ended" or event.phase == "cancelled" then
				t.isFocus = false
			end
		end
	else
		print ( t.name .. " touched" )
		if event.phase == "began" then
			t.isFocus = true;
			t.x0 = event.x - t.x
		elseif t.isFocus then
			if event.phase == "moved" then

				local newX = event.x - t.x0

				if newX > barMin and newX < (barMin + barW) then
					
					local newValue = (newX - barMin) / (barW)
					print ( newValue )
					local offset = 10 -- Just temporary
					local j = 1
					for i = 1, #pointersLow, 1 do
					--for _,i in ipairs( pointers ) do
						local pointerLow = pointersLow[i]
						local pointerHigh = pointersHigh[i];
						if pointerLow.name == t.name and newX <= pointerHigh.x then
							currentLowVals[j] = newValue
							t.x = newX
						elseif pointerHigh.name == t.name and newX >= pointerLow.x then
							currentHighVals[j] = newValue
							t.x = newX
						end
						j = j + 1
					end
					updateTextViews();
				end

			elseif event.phase == "ended" or event.phase == "cancelled" then
				t.isFocus = false
			end
		end
	end
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	transition.to( setTitle, { time = 600, delay = 0, alpha = 1 })
	transition.to( cals, { time = 600, delay = 0, alpha = 1 })
	transition.to( save, { time = 600, delay = 0, alpha = 1 })
	transition.to( cancel, { time = 600, delay = 0, alpha = 1 })
	
	for i = 1, 4, 1 do
		transition.to( icons[i], { time = 600, delay = 0, alpha = 1 })
	end

	for i = 1, 3, 1 do
		transition.to( bars[i], { time = 600, delay = 0, alpha = 1 })
		transition.to( pointersLow[i], { time = 600, delay = 0, alpha = 1 })
		transition.to( pointersHigh[i], { time = 600, delay = 0, alpha = 1 })
		transition.to( textViewsLow[i], { time = 600, delay = 0, alpha = 1 })
		transition.to( textViewsHigh[i], { time = 600, delay = 0, alpha = 1 })

		pointersLow[i]:addEventListener( "touch", sceneTouch )
		pointersHigh[i]:addEventListener( "touch", sceneTouch )
	end

	cals:addEventListener( "touch", sceneTouch )

	save:addEventListener( "touch", returnToLanding )
	cancel:addEventListener( "touch", returnToLanding )

	updateTextViews();
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	local animationTime = 600
	local delayTime = 0;
	transition.to( setTitle, { time = animationTime, delay = delayTime, alpha = 0 })
	transition.to( cals, { time = animationTime, delay = delayTime, alpha = 0 })
	transition.to( save, { time = animationTime, delay = delayTime, alpha = 0 })
	transition.to( cancel, { time = animationTime, delay = delayTime, alpha = 0 })
	
	for i = 1, 3, 1 do
		transition.to( bars[i], { time = animationTime, delay = 0, alpha = 0 })
		transition.to( pointersLow[i], { time = animationTime, delay = 0, alpha = 0 })
		transition.to( pointersHigh[i], { time = animationTime, delay = 0, alpha = 0 })
		transition.to( textViewsLow[i], { time = animationTime, delay = 0, alpha = 0 })
		transition.to( textViewsHigh[i], { time = animationTime, delay = 0, alpha = 0 })
		transition.to( icons[i], { time = animationTime, delay = 0, alpha = 0 })
	end	
	transition.to( icons[4], { time = animationTime, delay = 0, alpha = 0 }) -- The extra final icon.
	--if it wasn't saved, set the cals back to what they were initially
	cals.text = setArray[1]


	local j = 1
	for i = 1, #pointersLow, 1 do
		pointerLow = pointersLow[i]
		pointerHigh = pointersHigh[i]
		pointerLow.x = barMin + barW * setArray[i * 2]
		pointerHigh.x = barMin + barW * setArray[i * 2 + 1]
		for i = 1, #currentLowVals, 1 do
			currentLowVals[i] = setArray[i * 2]
			currentHighVals[i] = setArray[i * 2 + 1] 
		end
	end
	updateTextViews();

	Runtime:removeEventListener( "touch", sceneTouch )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	setTitle:removeSelf()
	cals:removeSelf()
	save:removeSelf()
	cancel:removeSelf()

	for i = 1, 4, 1 do
		bars[i]:removeSelf()
		icons[i]:removeSelf()
		pointersLow[i]:removeSelf()
		pointersHigh[i]:removeSelf()
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