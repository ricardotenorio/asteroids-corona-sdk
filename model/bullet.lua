local bullet = {}

function bullet:new( obj )
	obj  = obj or {}
	setmetatable( obj, self)
	self.__index = self

	return obj 
end

function bullet:fire( x, y )
	local newBullet = display.newRect( sceneGroup, x, y, 2, 5, 2 )
	physics.addBody( newBullet, "dynamic", { isSensor = true } )
	newbullet.isBullet = true
	newbullet.myName = "bullet"

	newbullet:toBack()

	-- transition and cleanup
	transition.to( newbullet, { y = -40, time = 500,
		onComplete = function() display.remove( newbullet ) end
	 } )

end