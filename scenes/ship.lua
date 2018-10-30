local ship = {}

local h = display.contentHeight
local w = display. contentWidth
local physics = require( "physics" )

-- test 
function ship:new( obj )
	obj = obj or {}
	setmetatable( obj, self )
	self.__index = self
	obj.body = display.newPolygon( w / 2, h / 2,  { 0, 0, 6, -16, 12, 0 } )
	physics.start( )
	physics.addBody( obj.body, "dynamic" )
	
	Runtime:addEventListener( "key", obj )
	--test
	Runtime:addEventListener( "enterFrame", obj.outOfBounds )
	
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
	local shipVelocity = getLinearVelocity(self.body.rotation, 100)
	

	if phase == "down" then
		if name == "w" then
			--self.body:setLinearVelocity( 0, 10 )
			--self.body:applyForce( 0, .1, self.body.x, self.body.y )
			--self.body:applyAngularImpulse( 1 )
			
			--[[
				https://stackoverflow.com/questions/39301171/move-object-in-the-direction-of-its-rotation
			]]--

			self.body:setLinearVelocity( shipVelocity.xVelocity, shipVelocity.yVelocity )

		end

		if name == "a" then
			self.body:applyTorque( -0.01 )
			print( self.body.rotation % 360  )
		elseif name == "d" then
			self.body:applyTorque( 0.01 )
			print( self.body.rotation % 360  )

		end

		if name == "space" then 

		end

	elseif phase == "up" then
		if name == "a" then
			self.body:applyTorque( 0.01 )
			print( self.body.rotation % 360  )
		elseif name == "d" then
			self.body:applyTorque( -0.01 )
			print( self.body.rotation % 360  )
		end
	end
		
end


-- test
function ship:outOfBounds ( event )
	if self.body.x < 0 then
		self.body.x = w
	elseif self.body.x > w then 
		self.body.x = 0
	end
end




return ship