local M = {}
local asteroid = require("model.asteroid")
local alien = require("model.alien")

local enemies = {}
local level = 1
local rNumber
local enemyValue
local group
local alienHasSpawn
local alienTimer

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
	table.insert( enemies, alien:new( nil, group ) )
end

function M.enterFrame( )

	if not alienHasSpawn then
		alienHasSpawn = true
		alienTimer = timer.performWithDelay( 20000, M.timer, 1 )
	end

	-- clean table and changes level
	local count = 0
	for k,v in pairs( enemies ) do
		if v.destroyed then
			v:remove()
			table.remove( enemies, k )
		elseif v == nil then
			count = count + 1
		end
	end

	if count == #enemies then
		level = level + 1
		timer.cancel( alienTimer )
		M.generateAsteroids()
		alienHasSpawn = false
	end
end

function M.start( sceneGroup )
	group = sceneGroup
	M.generateAsteroids( )

	Runtime:addEventListener( "enterFrame", M )
end

return M