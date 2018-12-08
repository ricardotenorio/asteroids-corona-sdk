local M = {}
local direction = require( "model.util.direction" )
local outOfBounds = require( "model.util.outOfBounds" )

local bulletVelocity

function M:new( rotation, x, y, group )
	obj = display.newRect( group, x, y, 2, 3, 2 )
	physics.addBody( obj, "dynamic", { isSensor = true } )
	obj.isobj = true
	obj.startTime = nil
	obj.name = "bullet"

	function obj:enterFrame( event )
		outOfBounds:checkPos( self )

		if self.startTime == nil then
			self.startTime = event.time / 1000
		elseif self.startTime <= ( event.time / 1000 - 1 ) then 
			self:remove()
		end
	end

	function obj:collision( event )
		local other = event.other
		local phase = event.phase

		if other.name == "enemy" then
			if phase == "began" then 
				local points = other.points
				playerScore:update( points )
				playerLives:update( points )
				other:remove( )
				self:remove( )
			end
		end
	end

	function obj:remove( )
		Runtime:removeEventListener( "enterFrame", self )
		display.remove( self )
		self = nil
	end

	obj:addEventListener( "collision" )
	Runtime:addEventListener( "enterFrame", obj )

	-- set bullet direction and speed
	bulletVelocity = direction:getLinearVelocity( rotation, 200 )
	obj:setLinearVelocity( bulletVelocity.xVelocity, bulletVelocity.yVelocity )

	return obj
end

return M