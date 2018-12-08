local M = {}

local w = display.contentWidth
local h = display.contentHeight

function M:new( obj, group )
	obj = obj or {}
	local options = { text = "Lives:\n3", x = (w / 12), y = 40, font = "kongtext.ttf", fontSize = 10, align = "center" }
	obj = display.newText( options )
	obj:setFillColor( .22, 1, .08 )
	obj.value = 3
	obj.next = 10000

	group:insert( obj )

	function obj:update( points )
		self.next = self.next - points
		if self.next <= 0 then
			self.value = self.value + 1
			self.next = self.next + 10000
		end

		self.text = "Lives:\n" .. self.value
	end

	function obj:remove( )
		display.remove( self )
		self = nil
	end

	return obj
end

return M