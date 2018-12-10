local M = {}

local bullet = require( "model.bullet" )
local direction = require( "model.util.direction")
local outOfBounds = require( "model.util.outOfBounds")

local h = display.contentHeight
local w = display.contentWidth
local accelerationTimer
local respawnTimer
local speedLimit

-- test 
function M:new( obj, group )
	obj = obj or {}
	speedLimit = 190
	
	obj = display.newPolygon( w / 2, h / 2, { 0, 0, 6, -16, 12, 0 } )
	physics.addBody( obj, "dynamic" )
	obj.bullets = {}
	obj.name = "player"
	
	group:insert( obj )

	function obj:touch( event )
		local name = event.target.name
		local phase = event.phase

		if phase == "began" then
			if name == "up" then
				-- Updates the velocity every 5 frames (I think...)
				if not accelerationTimerTouch then
					accelerationTimerTouch = timer.performWithDelay( 83, self, 0 )
				end
			end

			if name == "left" then
				self:applyTorque( -0.015 )
			elseif name == "right" then
				self:applyTorque( 0.015 )
			end

			if name == "fire" and self.isVisible then 
				self:fire()
			end

		elseif phase == "ended" then
			if name == "up" then
				if accelerationTimerTouch then
					timer.cancel( accelerationTimerTouch )
					accelerationTimerTouch = nil
				end
			end
			if name == "left" then
				obj.angularVelocity = 0
			elseif name == "right" then
				obj.angularVelocity = 0

			end
		end
	end

	function obj:key( event )
		local name = event.keyName
		local phase = event.phase

		if phase == "down" then
			if name == "w" then
				-- Updates the velocity every 5 frames (I think...)
				accelerationTimer = timer.performWithDelay( 83, self, 0 )
			end

			if name == "a" then
				self:applyTorque( -0.015 )
			elseif name == "d" then
				self:applyTorque( 0.015 )
			end

			if name == "space" and self.isVisible then 
				self:fire()
			end

		elseif phase == "up" then
			if name == "w" then
				timer.cancel( accelerationTimer )
			end
			if name == "a" then
				obj.angularVelocity = 0
			elseif name == "d" then
				obj.angularVelocity = 0

			end
		end
			
	end

	function obj:timer( event )
		local acceleration = 25

		local currentVelocityX, currentVelocityY = self:getLinearVelocity( )
		local shipVelocity = direction:getLinearVelocity( self.rotation, acceleration )

		-- 
		if shipVelocity.xVelocity + currentVelocityX > speedLimit then
			shipVelocity.xVelocity = speedLimit
		elseif shipVelocity.xVelocity + currentVelocityX < -speedLimit then
			shipVelocity.xVelocity = -speedLimit
		else
			shipVelocity.xVelocity = shipVelocity.xVelocity + currentVelocityX
		end

		if shipVelocity.yVelocity + currentVelocityY > speedLimit then
			shipVelocity.yVelocity = speedLimit
		elseif shipVelocity.yVelocity + currentVelocityY < -speedLimit then
			shipVelocity.yVelocity = -speedLimit
		else
			shipVelocity.yVelocity = shipVelocity.yVelocity + currentVelocityY
		end

		self:setLinearVelocity( shipVelocity.xVelocity, shipVelocity.yVelocity )
	end

	function obj:collision( event )
		local other = event.other
		local phase = event.phase

		if other.name == "enemy" or other.name == "enemyBullet" then
			if phase == "began" and self.isVisible then 
				self.isVisible = false
				playerLives.value = playerLives.value - 1
				playerLives:update( 0 )
				if playerLives.value == 0 then
					self:remove()
				else
					respawnTimer = timer.performWithDelay( 1000, respawn, 1 )
				end
			elseif phase == "ended" then
				if other.name == "enemyBullet" then
					other:remove( )
				end
			end
		end
	end

	function respawn( )
		obj.x = w / 2 
		obj.y = h / 2
		obj:setLinearVelocity( 0, 0)
		obj.angularVelocity = 0
		obj.rotation = 0
		obj.isVisible = true
	end

	function obj:fire( )
		self.bullets = bullet:new( self.rotation, self.x, self.y, group )
	end

		
	function obj:enterFrame ( event )
		outOfBounds:checkPos( self )
	end

	function obj:remove( )
		Runtime:removeEventListener( "enterFrame", self )
		Runtime:removeEventListener( "key", self )
		obj:removeEventListener( "collision" )

		if accelerationTimer then
			timer.cancel( accelerationTimer )
		end
		if accelerationTimerTouch then
			timer.cancel( accelerationTimerTouch )
		end

		timer.cancel( respawnTimer )
		display.remove( self )
		self = nil
	end

	obj:addEventListener( "collision" )
	Runtime:addEventListener( "key", obj )
	Runtime:addEventListener( "enterFrame", obj )

	return obj
end

return M
