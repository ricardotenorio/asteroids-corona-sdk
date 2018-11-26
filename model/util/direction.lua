local M = {}


-- return linear velocity based on object direction
-- https://stackoverflow.com/questions/39301171/move-object-in-the-direction-of-its-rotation

function M:getLinearVelocity( rotation, velocity )
	local angle = math.rad( rotation )
	return {
		xVelocity = math.sin(angle) * velocity,
		yVelocity = math.cos(angle) * -velocity
	}
end 

return M