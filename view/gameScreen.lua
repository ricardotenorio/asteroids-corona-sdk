local composer = require( "composer" )
local physics = require( "physics" )
local ship = require( "model.ship" )
--local asteroid = require( "model.asteroid")
local score = require( "model.score" )
local lives = require( "model.lives" )
local level = require( "model.levelgenerator" )

local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local player, asteroids

 
 
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

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
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
        level:remove( ) 
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