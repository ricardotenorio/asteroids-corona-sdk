local M = {}
local asteroid = require("model.asteroid")
local alien = require("model.alien")

local enemies
local level
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
			if v.size ~= nil and v.size > 1 then
				table.insert( enemies, asteroid:new( nil, v.size - 1, group, { v.x, v.y } ) )
				table.insert( enemies, asteroid:new( nil, v.size - 1, group, { v.x, v.y } ) )
			end
			v:remove()
			table.remove( enemies, k )
		elseif v == nil then
			count = count + 1
		end
	end

	if count == #enemies then
		level = level + 1
		playerScore:update( 1000 )
		timer.cancel( alienTimer )
		M.generateAsteroids()
		alienHasSpawn = false
	end
end

function M.start( sceneGroup )
	enemies = {}
	level = 1
	group = sceneGroup
	alienHasSpawn = false
	M.generateAsteroids( )

	Runtime:addEventListener( "enterFrame", M )
end

function M:remove( )
	if enemies ~= nil then
		for i=1, #enemies do
			if enemies[i] ~= nil then
				enemies[i]:remove()
				table.remove( enemies, i )
			end		
		end
	end

	timer.cancel( alienTimer )
	Runtime:removeEventListener( "enterFrame", M )
	enemies = nil
	self = nil
end

return M