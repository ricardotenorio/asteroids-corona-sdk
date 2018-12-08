local M = {}
local asteroid = require("model.asteroid")
local alien = require("model.alien")

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

function M.timer( )
	-- body
end


function M.start( sceneGroup )
	group = sceneGroup
	enemies[1] = alien:new( nil, group )
	M.generateAsteroids( )
end

return M