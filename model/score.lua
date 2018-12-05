local M = {}

local score = {}
local w = display.contentWidth
local h = display.contentHeight

function M:new( obj, group )
	obj = obj or {}
	local options = { text = "Score:\nTest0123456789", x = (w / 2), y = 20, font = "kongtext.ttf", fontSize = 12, align = "center" }
	obj = display.newText( options )
	obj:setFillColor( .22, 1, .08 )
	obj.value = 0

	group:insert( obj )

	function obj:update( points )
		self.value = points
		self.text = "Score:\n" .. self.value
	end

	return obj
end

return M