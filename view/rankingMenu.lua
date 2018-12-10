local composer = require( "composer" )
local database = require( "model.database.database")
 
local scene = composer.newScene()
local h = display.contentHeight
local w = display.contentWidth
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local rankingText, returnButton, returnText, mainMenu, options

mainMenu = function( event )
    composer.gotoScene( "view.mainMenu" )
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
        if event.params then
            database.newRanking( event.params )
        end

        database.getRanking( sceneGroup )
 
    elseif ( phase == "did" ) then

        options = { parent = sceneGroup, text = "Hi-Score", x = w / 2, y = 20,
            font = "kongtext.ttf", fontSize = 20, align = "center" }
        rankingText = display.newText( options )

        returnButton = display.newRect( sceneGroup, w / 2, h - 50 , 200, 25 )
        options = { parent = sceneGroup, text = "Return", x = returnButton.x, y = returnButton.y,
            font = "kongtext.ttf", fontSize = 20, align = "center" }
        returnText = display.newText( options )
        returnButton:setFillColor( .22, 1, .05 )
    
        returnButton:addEventListener( "tap", mainMenu )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        database.remove()
 
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