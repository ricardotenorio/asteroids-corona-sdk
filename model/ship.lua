local M = {}

local bullet = require( "model.bullet" )
local physics = require( "physics" )
local direction = require( "model.util.direction")

local ship = {}
local h = display.contentHeight
local w = display.contentWidth

-- test 
function M:new( obj, group )
	obj = obj or {}
	
	obj = display.newPolygon( w / 2, h / 2,  { 0, 0, 6, -16, 12, 0 } )
	physics.start( )
	physics.setGravity( 0, 0 )
	physics.addBody( obj, "dynamic" )
	obj.bullets = {}
	
	Runtime:addEventListener( "key", obj )
	--test
	Runtime:addEventListener( "enterFrame", obj )
	group:insert( obj )

	function obj:key( event )
		local name = event.keyName
		local phase = event.phase
		local shipVelocity = direction:getLinearVelocity(self.rotation, 130)
		

		if phase == "down" then
			if name == "w" then			
				self:setLinearVelocity( shipVelocity.xVelocity, shipVelocity.yVelocity )

			end

			if name == "a" then
				self:applyTorque( -0.01 )
			elseif name == "d" then
				self:applyTorque( 0.01 )
			end

			if name == "space" then 
				self:fire()
			end

		elseif phase == "up" then
			if name == "a" then
				self:applyTorque( 0.01 )
			elseif name == "d" then
				self:applyTorque( -0.01 )
			end
		end
			
	end

	function obj:fire( )
		self.bullets = bullet:new( self.rotation, self.x, self.y, group )
	end

		
	function obj:enterFrame ( event )
		if self.x < -40 then
			self.x = w + 40
		elseif self.x > w + 45 then 
			self.x = -40
		elseif self.y < -15 then
			self.y = h + 10
		elseif self.y > h + 15 then
			self.y = -10
		end
	end

	return obj
end

return M
