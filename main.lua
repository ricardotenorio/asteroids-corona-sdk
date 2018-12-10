-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require( "composer" )
local isMobile = ( "ios" == system.getInfo("platform") ) or ( "android" == system.getInfo("platform") )
display.setStatusBar( display.HiddenStatusBar ) 
system.activate( "multitouch" )

composer.gotoScene( "view.mainMenu", { params = isMobile and not "simulator" == system.getInfo( "environment" ) } )
