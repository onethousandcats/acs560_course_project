-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require "storyboard"

local w = display.viewableContentWidth
local h = display.viewableContentHeight

local dw = display.pixelWidth
local dh = display.pixelHeight

local back = display.newGroup()

local g = graphics.newGradient(
	{ 46, 207, 194 },
	{ 210, 95, 182 },
	"down")

local bg = display.newRect( 0, 0, dw, dh )
--bg:setFillColor( 0, 100, 140 )
bg:setFillColor( g )
bg.x = w / 2; bg.y = h / 2

-- load landing.lua
storyboard.gotoScene( "landing" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):
