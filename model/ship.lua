local M = {}

local bullet = require( "model.bullet" )
local direction = require( "model.util.direction")
local outOfBounds = require( "model.util.outOfBounds")

local h = display.contentHeight
local w = display.contentWidth

-- test 
function M:new( obj, group )
	obj = obj or {}
	
	obj = display.newPolygon( w / 2, h / 2, { 0, 0, 6, -16, 12, 0 } )
	physics.addBody( obj, "dynamic" )
	obj.bullets = {}
	obj.name = "player"
	
	group:insert( obj )

	function obj:key( event )
		local name = event.keyName
		local phase = event.phase
		local shipVelocity = direction:getLinearVelocity(self.rotation, 150)
		

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

	function obj:fire( )
		self.bullets = bullet:new( self.rotation, self.x, self.y, group )
	end

		
	function obj:enterFrame ( event )
		outOfBounds:checkPos( self )
	end

	function obj:remove( )
		Runtime:removeEventListener( "enterFrame", self )
		display.remove( self )
		self = nil
	end

	obj:addEventListener( "collision" )
	Runtime:addEventListener( "key", obj )
	Runtime:addEventListener( "enterFrame", obj )

	return obj
end

return M
