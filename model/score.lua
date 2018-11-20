local M = {}

local score = {}
local w = display.contentWidth
local h = display.contentHeight

function M:new( obj, group )
	obj = obj or {}
	local options = { text = "Score:\nTest", x = (w / 2), y = 20, font = native.systemFont, align = "center" }
	obj = display.newText( options )
	obj.value = 0

	group:insert( obj )

	function obj:update( points )
		self.value = points
		self.text = "Score:\n" .. self.value
	end

	return obj
end

return M