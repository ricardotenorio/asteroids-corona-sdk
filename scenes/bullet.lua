local bullet = {}

function bullet:new( obj )
	obj  = obj or {}
	setmetatable( obj, self)
	self.__index = self

	return obj 
end

function bullet:( ... )
	-- body
end