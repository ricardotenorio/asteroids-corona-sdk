local M = {}
local direction = require( "model.util.direction" )
local outOfBounds = require( "model.util.outOfBounds" )

local h = display.contentHeight
local w = display.contentWidth
local asteroidDirection

function M:new( obj, group, size )
	obj = obj or {}
	size = size or 3

	obj = display.newCircle( 50, 50, 30 )
	obj.fill = { 0, 0, 0, 0.5 }
	obj.strokeWidth = 2
	obj.name = "asteroid"

	physics.addBody( obj, "dynamic" )
	group:insert(obj)

	Runtime:addEventListener( 'enterFrame', obj)

	asteroidDirection = direction:getLinearVelocity( math.random( 0, 360 ), 50 )
	obj:setLinearVelocity( asteroidDirection.xVelocity, asteroidDirection.yVelocity )

	function obj:enterFrame ( event )
		outOfBounds:checkPos( self )
	end

	function obj:remove( )
		Runtime:removeEventListener( "enterFrame", self )
		display.remove( self )
		self = nil
	end

	return obj
end

return M