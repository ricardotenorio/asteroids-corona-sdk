local composer = require( "composer" )
local physics = require( "physics" )
local ship = require( "model.ship" )
--local asteroid = require( "model.asteroid")
local score = require( "model.score" )
local lives = require( "model.lives" )
local level = require( "model.levelgenerator" )

local h = display.contentHeight
local w = display.contentWidth
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local player, asteroids, gameOver, addControls, buttons

addControls = function( sceneGroup )
    buttons[1] = display.newRoundedRect( 10, h - 40, 40, 25, 8 )
    buttons[1]:setFillColor( .22, 1, .05, .5 )
    sceneGroup:insert( buttons[1] )
    buttons[2] = display.newRoundedRect( 70, h - 40, 40, 25, 8 )
    buttons[2]:setFillColor( .22, 1, .05, .5 )
    sceneGroup:insert( buttons[2] )
    buttons[3] = display.newRoundedRect( 40, h - 80, 25, 40, 8 )
    buttons[3]:setFillColor( .22, 1, .05, .5 )
    sceneGroup:insert( buttons[3] )
    buttons[4] = display.newCircle( w - 30, h - 50, 30 )
    buttons[4]:setFillColor( 1, .22, .05, .5 )
    sceneGroup:insert( buttons[4] )

end

gameOver = function( event )
    if playerLives.value == 0 then
        local score = playerScore.value
        composer.removeScene( "view.gameScreen" )
        composer.gotoScene( "view.rankingMenu", { effect="fade", time=800, params=score } )
    end
    
end

 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    math.randomseed( os.time( ) )
    physics.start()
    physics.setGravity( 0, 0 )
    player = ship:new( nil, sceneGroup )
    --asteroids = {}
    --table.insert( asteroids, asteroid:new( nil, sceneGroup ))
    --table.insert( asteroids, asteroid:new( nil, sceneGroup ))

    ----------------GLOBAL--------------------
    playerScore = score:new( nil, sceneGroup )
    playerLives = lives:new( nil, sceneGroup )
    ------------------------------------------
    level.start( sceneGroup )

    Runtime:addEventListener( "enterFrame", gameOver ) 

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        if event.params then
            buttons = {}
            addControls( sceneGroup )
        end
     
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
      -- Runtime:addEventListener("enterFrame", test)
 
    end
end

 -- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
       
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    level:remove( )
    Runtime:removeEventListener( "enterFrame", gameOver ) 
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