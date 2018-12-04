local M = {}
local direction = require( "model.util.direction" )
local outOfBounds = require( "model.util.outOfBounds" )

local bullet = {}
local bulletVelocity

function M:new( rotation, x, y, group )
	bullet = display.newRect( group, x, y, 2, 3, 2 )
	physics.addBody( bullet, "dynamic", { isSensor = true } )
	bullet.isBullet = true
	bullet.myName = "bullet"
	bullet.startTime = nil

	-- Test
	function bullet:enterFrame( event )
		outOfBounds:checkPos( self )

		if self.startTime == nil then
			self.startTime = event.time / 1000
		elseif self.startTime <= ( event.time / 1000 - 1 ) then 
			self:remove()
		end

	end

	function bullet:remove( )
		Runtime:removeEventListener( "enterFrame", self )
		display.remove( self )
		self = nil
	end

	Runtime:addEventListener( "enterFrame", bullet )
	bulletVelocity = direction:getLinearVelocity( rotation, 150 )
	bullet:setLinearVelocity( bulletVelocity.xVelocity, bulletVelocity.yVelocity )

	return bullet
end

return M