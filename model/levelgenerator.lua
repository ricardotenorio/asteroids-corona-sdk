local M = {}
local asteroid = require("model.asteroid")

local enemies = {}
local level = 1
local rNumber
local enemyValue
local group

function M.generateAsteroids( )
	
	if level % 2 == 1 then
		table.insert( enemies, asteroid:new( nil, 3, group ) )
		table.insert( enemies, asteroid:new( nil, 3, group ) )
		enemyValue = 22
	else
		table.insert( enemies, asteroid:new( nil, 2, group ) )
		table.insert( enemies, asteroid:new( nil, 2, group ) )
		table.insert( enemies, asteroid:new( nil, 2, group ) )
		table.insert( enemies, asteroid:new( nil, 2 , group ) )
		enemyValue = 16
	end	
end


function M.start( sceneGroup )
	group = sceneGroup
	M.generateAsteroids( )
end

return M