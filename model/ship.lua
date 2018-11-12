local ship = {}
local bullet = require( "model.bullet" )
local physics = require( "physics" )

local h = display.contentHeight
local w = display. contentWidth

-- test 
function ship:new( obj )
	obj = obj or {}
	setmetatable( obj, self )
	self.__index = self
	obj.body = display.newPolygon( w / 2, h / 2,  { 0, 0, 6, -16, 12, 0 } )
	physics.start( )
	physics.setGravity( 0, 0 )
	physics.addBody( obj.body, "dynamic" )
	
	Runtime:addEventListener( "key", obj )
	--test
	Runtime:addEventListener( "enterFrame", obj )
	
	return obj
end

local function getLinearVelocity( rotation, velocity )
  local angle = math.rad( rotation )
  return {
    xVelocity = math.sin(angle) * velocity,
    yVelocity = math.cos(angle) * -velocity
  }
end

function ship:key( event )
	local name = event.keyName
	local phase = event.phase
	local shipVelocity = getLinearVelocity(self.body.rotation, 130)
	

	if phase == "down" then
		if name == "w" then			
			--[[
				https://stackoverflow.com/questions/39301171/move-object-in-the-direction-of-its-rotation
			]]--

			self.body:setLinearVelocity( shipVelocity.xVelocity, shipVelocity.yVelocity )

		end

		if name == "a" then
			self.body:applyTorque( -0.01 )
		elseif name == "d" then
			self.body:applyTorque( 0.01 )
		end

		if name == "space" then 

		end

	elseif phase == "up" then
		if name == "a" then
			self.body:applyTorque( 0.01 )
		elseif name == "d" then
			self.body:applyTorque( -0.01 )
		end
	end
		
end


-- test
function ship:enterFrame ( event )
	if self.body.x < -40 then
		self.body.x = w + 40
	elseif self.body.x > w + 45 then 
		self.body.x = -40
	elseif self.body.y < -15 then
		self.body.y = h + 10
	elseif self.body.y > h + 15 then
		self.body.y = -10
	end
end


return ship