local M = {}
local direction = require( "model.util.direction" )
local outOfBounds = require( "model.util.outOfBounds" )
local bullet = {}

function M:new( rotation, x, y, group )
	bullet = display.newRect( group, x, y, 2, 3, 2 )
	physics.addBody( bullet, "dynamic", { isSensor = true } )
	bullet.isBullet = true
	bullet.myName = "bullet"
	bullet.startTime = os.time()

	-- Test
	function bullet:enterFrame( event )
		outOfBounds:checkPos( self )
		print( os.difftime(self.startTime, os.time()))

		if self.startTime >= ( os.time() - 2 ) then 
			self:remove()
		end

	end

	function bullet:remove( )
		Runtime:removeEventListener( "enterFrame", self )
		display.remove( self )
		self = nil
	end

	Runtime:addEventListener( "enterFrame", bullet )
	--timer.performWithDelay( 1000, bullet, 1 )
	bulletVelocity = direction:getLinearVelocity( rotation, 150 )
	bullet:setLinearVelocity( bulletVelocity.xVelocity, bulletVelocity.yVelocity )

	return bullet
end

return M