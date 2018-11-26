local M = {}
local direction = require("model.util.direction")
local bullet = {}

function M:new( rotation, x, y, group )
	bullet = display.newRect( group, x, y, 2, 3, 2 )
	physics.addBody( bullet, "dynamic", { isSensor = true } )
	bullet.isBullet = true
	bullet.myName = "bullet"
	bullet.startPos = { x, y }

	-- Test
	function bullet:enterFrame( event )
		local distance = 0
		--print( self.startPos[1] , self.startPos[2] )
		print( self.x , self.y )
		distance = ( self.x % self.startPos[1] ) + ( self.y % self.startPos[2] )

		if distance >= 100 then 
			Runtime:removeEventListener( "enterFrame", self )
			self:removeSelf()
			self = nil
		end

	end

	Runtime:addEventListener( "enterFrame", bullet )
	--timer.performWithDelay( 1000, bullet, 1 )
	bulletVelocity = direction:getLinearVelocity( rotation, 150 )
	bullet:setLinearVelocity( bulletVelocity.xVelocity, bulletVelocity.yVelocity )

	return bullet
end

return M