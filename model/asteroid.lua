local M = {}
local direction = require( "model.util.direction" )
local outOfBounds = require( "model.util.outOfBounds" )

local h = display.contentHeight
local w = display.contentWidth
local asteroidDirection
local position

local function generatePosition( )
	local rnumber = math.random( 1, 4 )
	local x, y
	if rnumber == 1 then
		x = w / 4
		y = h / 4
	elseif rnumber == 2 then
		x = w / 4 * 3
		y = h / 4
	elseif rnumber == 3 then
		x = w / 4
		y = h / 4 * 3
	else
		x = w / 4 * 3
		y = h / 4 * 3
	end
	return { x, y }
end

function M:new( obj, size, group )
	obj = obj or {}
	size = size or 1
	position = generatePosition()

	if size == 1 then
		obj = display.newCircle( position[1], position[2], 5 )
		obj.points = 100
		obj.size = 1
	elseif size == 2 then
		obj = display.newCircle( position[1], position[2], 15 )
		obj.points = 50
		obj.size = 2
	else
		obj = display.newCircle( position[1], position[2], 35 )
		obj.points = 25
		obj.size = 3
	end
	
	obj.fill = { 0, 0, 0, 0.5 }
	obj.strokeWidth = 2
	obj.name = "enemy"
	obj.destroyed = false
	group:insert( obj )

	physics.addBody( obj, "dynamic", { bounce = 1 } )

	Runtime:addEventListener( 'enterFrame', obj)

	asteroidDirection = direction:getLinearVelocity( math.random( 0, 360 ), 150 / obj.size )
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