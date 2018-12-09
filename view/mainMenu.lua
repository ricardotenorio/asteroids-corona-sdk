local composer = require( "composer" )
 
local scene = composer.newScene()
local h = display.contentHeight
local w = display.contentWidth
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local newGame, ranking, gameText, rankingText, start, title

start = function( event ) 
    composer.gotoScene( "view.gameScreen" )
end
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        newGame = display.newRect( sceneGroup, w / 2, h / 2, 200, 40 )
        local options = { parent = sceneGroup, text = "New Game", x = newGame.x, y = newGame.y,
            font = "kongtext.ttf", fontSize = 20, align = "center" }
        gameText = display.newText( options )
        gameText:setFillColor( .22, 1, .05 )

        ranking = display.newRect( sceneGroup, w / 2, h / 4 * 3, 200, 40 )
        options = { parent = sceneGroup, text = "Ranking", x = ranking.x, y = ranking.y,
            font = "kongtext.ttf", fontSize = 20, align = "center" }
        rankingText = display.newText( options )
        ranking:setFillColor( .22, 1, .05 )

        options = { parent = sceneGroup, text = "Asteroids\n(...)", x = w / 2, y = h / 4,
            font = "kongtext.ttf", fontSize = 25, align = "center" }
        title = display.newText( options )
        title:setFillColor( .22, 1, .05 )
 
        newGame:addEventListener( "tap", start )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene