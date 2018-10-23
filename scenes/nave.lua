local nave = {}


-- test 
function nave.new( )
	local h = display.contentHeight
	local w = display. contentWidth

	local grafico = display.newPolygon( w / 2, h / 2,  { 0, 0, 6, -16, 12, 0 } )

	physics.addBody( grafico, "dynamic")




	--Runtime:addEventListener( "key", key )

end

return nave