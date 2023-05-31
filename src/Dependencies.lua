--
-- libraries
--
anim8 = require 'assets/lib/anim8'
baton = require 'assets/lib/baton'
camera = require 'assets/libs/camera'
Class = require 'assets/lib/class'
Event = require 'assets/lib/knife.event'
gamera = require 'assets/lib/gamera'
push = require 'assets/lib/push'
sti = require 'assets/lib/sti'
Timer = require 'assets/lib/knife.timer'
wf = require 'assets/lib/windfield'


--
-- Scripts
--
require 'src/constants'
require 'src/StateMachine'
require 'src/utils'

require 'src/entity/entity_defs'
require 'src/entity/Entity'
require 'src/entity/Player'

require 'src/gui/Menu'
require 'src/gui/Panel'
require 'src/gui/Selection'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityFallState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityJumpState'
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerFallState'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerWalkState'

require 'src/states/game/PauseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

require 'src/world/Level'


--
-- variables
--

p1_input = baton.new {
    controls = {
        -- options input
        start           = {'key:p', 'button:start'},
        escape          = {'key:escape'},

        -- menu related input
        interact        = {'key:return', 'button:a'},

        -- movement input
        left            = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right           = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up              = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down            = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},

        -- actions input
        main_action     = {'axis:triggerright+', 'mouse:1'},
        side_action     = {'axis:triggerleft+', 'mouse:2'},
        jump            = {'key:space', 'button:a'},
    },
    pairs = {
        move = {'left', 'right','up', 'down'},
    },
    joystick = love.joystick.getJoysticks()[1],
    deadzone = 0.5
}

gFonts = {
    small = love.graphics.newFont('assets/fonts/font.ttf', 8),
    medium = love.graphics.newFont('assets/fonts/font.ttf', 16),
    big = love.graphics.newFont('assets/fonts/font.ttf', 32),
    huge = love.graphics.newFont('assets/fonts/font.ttf', 64),
}

gTextures = {
    ['cursor'] = love.graphics.newImage('assets/img/cursor.png'),
    ['player_fall'] = love.graphics.newImage('assets/img/player/fall.png'),
    ['player_idle'] = love.graphics.newImage('assets/img/player/idle.png'),
    ['player_jump'] = love.graphics.newImage('assets/img/player/jump.png'),
    ['player_walk'] = love.graphics.newImage('assets/img/player/run.png'),
}

gGrids = {
    ['player_fall'] = anim8.newGrid(gTextures['player_fall'], 25, 28),
    ['player_idle'] = anim8.newGrid(gTextures['player_idle'], 24, 28),
    ['player_walk'] = anim8.newGrid(gTextures['player_walk'], 24, 28),
    ['player_jump'] = anim8.newGrid(gTextures['player_jump'], 26, 31),
}

-- choose color according to game colors and style. Placeholder only
-- from coolors.co ()
gColors = {
    ['ImperialRed'] = {249/255, 65/255, 68/255},
    ['OrangeCrayola'] = {243/255, 114/255, 44/255},
    ['CarrotOrange'] = {248/255, 150/255, 30/255},
    ['Coral'] = {249/255, 132/255, 74/255},
    ['Saffron'] = {249/255, 199/255, 79/255},
    ['Pistachio'] = {144/255, 190/255, 109/255},
    ['Zomp'] = {67/255, 170/255, 139/255},
    ['DarkCyan'] = {77/255, 144/255, 142/255},
    ['PaynesGray'] = {87/255, 117/255, 144/255},
    ['Cerulean'] = {39/255, 125/255, 161/255},
}
