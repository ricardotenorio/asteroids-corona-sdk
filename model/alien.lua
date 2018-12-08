local M = {}
local direction = require( "model.util.direction" )
local outOfBounds = require( "model.util.outOfBounds" )

local h = display.contentHeight
local w = display.contentWidth
local alienDirection
local fireTimer

function M:new( obj, group )
	obj = obj or {}

	obj = display.newPolygon( w, h, { 0, 0, 16, -8, 32, 0 } )
	obj.points = 100
	
	obj.fill = { .5, 0, 0, 0.5 }
	obj.strokeWidth = 2
	obj.name = "enemy"
	group:insert( obj )

	physics.addBody( obj, "dynamic", { isSensor = true } )

	Runtime:addEventListener( 'enterFrame', obj)

	alienDirection = direction:getLinearVelocity( math.random( 0, 360 ), 100 )
	obj:setLinearVelocity( alienDirection.xVelocity, alienDirection.yVelocity )

	function obj:enterFrame ( event )
		outOfBounds:checkPos( self )
	end

	function obj:remove( )
		Runtime:removeEventListener( "enterFrame", self )
		timer.cancel( fireTimer )
		display.remove( self )
		self = nil
	end

	function obj:timer( event )
		bullet = display.newRect( group, self.x, self.y, 2, 5, 2 )
		physics.addBody( bullet, "dynamic", { isSensor = true } )
		bullet.startTime = nil
		bullet.name = "enemyBullet"
		bullet.fill = { 1, 0, 0 }

		function bullet:enterFrame( event )
			outOfBounds:checkPos( self )

			if self.startTime == nil then
				self.startTime = event.time / 1000
			elseif self.startTime <= ( event.time / 1000 - 1.5 ) then 
				self:remove()
			end
		end

		function bullet:remove( )
			Runtime:removeEventListener( "enterFrame", self )
			display.remove( self )
			self = nil
		end

		Runtime:addEventListener( "enterFrame", bullet )

		-- set bullet direction and speed
		local bulletVelocity = direction:getLinearVelocity( math.random( 1, 360 ), 150 )
		bullet:setLinearVelocity( bulletVelocity.xVelocity, bulletVelocity.yVelocity )
	end

	fireTimer = timer.performWithDelay( 1500, obj, 0 )

	return obj
end

return M