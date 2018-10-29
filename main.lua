-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require( "composer" )
local ship = require( "scenes.ship" )
--local physics = require( "physics" )

local s = ship:new()


--physics.start( )
physics.setGravity( 0, 0 )
--physics.addBody( s )

--timer.performWithDelay( 10000, s:applyTorque( .01 ) , 1 )