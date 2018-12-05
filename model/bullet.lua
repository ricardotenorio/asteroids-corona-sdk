local M = {}
local direction = require( "model.util.direction" )
local outOfBounds = require( "model.util.outOfBounds" )

local bulletVelocity

function M:new( rotation, x, y, group )
	obj = display.newRect( group, x, y, 2, 3, 2 )
	physics.addBody( obj, "dynamic", { isSensor = true } )
	obj.isobj = true
	obj.myName = "obj"
	obj.startTime = nil
	obj.name = "bullet"

	-- Test
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

		if other.name == "asteroid" then
			if phase == "began" then 
				print( self.name, "collision", other.name)
			elseif phase == "ended" then 
				print( "collision ended" )
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
	bulletVelocity = direction:getLinearVelocity( rotation, 150 )
	obj:setLinearVelocity( bulletVelocity.xVelocity, bulletVelocity.yVelocity )

	return obj
end

return M