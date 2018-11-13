local score = {}

local w = display.contentWidth
local h = display.contentHeight

function score:new( group )
	local options = { text = "Score:\nTest", x = (w / 2), y = 20, font = native.systemFont, align = "center"}
	self = display.newText( options )
	self.value = 0

	group:insert( self )
end

function score:update( points )
	self.value = self.value + points
	self.text = "Score:\n" .. self.value
end

return score