local M = {}
local direction = require("model.direction")
local bullet = {}

function M:new( rotation, x, y, group )
	print ( teste )
	print ( rotation )
	bullet = display.newRect( group, x, y, 2, 3, 2 )
	physics.addBody( bullet, "dynamic", { isSensor = true } )
	bullet.isBullet = true
	bullet.myName = "bullet"

	bulletVelocity = direction:getLinearVelocity( rotation, 150 )
	bullet:setLinearVelocity( bulletVelocity.xVelocity, bulletVelocity.yVelocity )

	return bullet
end

return M