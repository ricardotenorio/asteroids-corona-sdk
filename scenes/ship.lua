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
	return obj
end

function ship:key( event )
	local name = event.keyName
	local phase = event.phase

	if phase == "down" then
		if name == "w" then
			self.body:setLinearVelocity( 0, 10 )
			--self.body:applyForce( 0, .1, self.body.x, self.body.y )
			--self.body:applyAngularImpulse( 1 )
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

return ship