local M = {}

local h = display.contentHeight
local w = display.contentWidth

function M:checkPos( obj )

	if obj.x < -40 then
		obj.x = w + 40
	elseif obj.x > w + 45 then 
		obj.x = -40
	elseif obj.y < -15 then
		obj.y = h + 10
	elseif obj.y > h + 15 then
		obj.y = -10
	end

end

return M