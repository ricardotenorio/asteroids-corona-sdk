local M = {}

local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "ranking.db", system.DocumentsDirectory )
local db = sqlite3.open( path )
local w = display.contentWidth
local h = display.contentHeight
local dummyData
local rankingText

local function onSystemEvent( event )
    if ( event.type == "applicationExit" ) then             
        db:close()
    end
end

local createTable = [[CREATE TABLE IF NOT EXISTS ranking (id INTEGER PRIMARY KEY, name TEXT, points INTEGER);]]
print( createTable )
db:exec( createTable )

dummyData = function()
	local values = {}
	values[1] = "aaa"
	values[2] = "ast"
	values[3] = "ids"
	values[4] = "jck"
	values[5] = "jro"
	values[6] = "joe"

	for i = 1, #values do
		local insertTable = [[INSERT INTO ranking (name, points) VALUES (']]..values[i]..[[',']]..(10000 * i)..[[');]]
		db.exec( insertTable )
	end
end

function M.getRanking( group )
	local count = 0
	rankingText = {}

	for row in db:nrows("SELECT name, points FROM ranking ORDER BY points LIMIT 5") do
		count = count + 1
	    local rowtext = row.name .. " " .. row.points
	    local options = { text = count .. rowtext, x = w / 2, y = (h / 2) * count, font = "kongtext.ttf", fontSize = 20, align = "center" }
	    table.insert( rankingText, display.newText( options ) )
	    rankingText[count]:setFillColor( .22, 1, .05 )
	    group:insert( rankingText[count] )
	end

	if count == 0 then
		dummyData()
		M.getRanking
	end
end

function M.newRanking( points )
	local insertTable = [[INSERT INTO ranking (name, points) VALUES ('player',']]..points..[[');]]
	db.exec( insertTable )
end

function M.remove()
	Runtime:removeEventListener( "system", onSystemEvent )
end

Runtime:addEventListener( "system", onSystemEvent )

return M