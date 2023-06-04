--
-- libraries
--
anim8 = require 'assets/lib/anim8'
baton = require 'assets/lib/baton'
Class = require 'assets/lib/class'
Event = require 'assets/lib/knife.event'
push = require 'assets/lib/push'
sti = require 'assets/lib/sti'
Timer = require 'assets/lib/knife.timer'
wf = require 'assets/lib/windfield'


--
-- Scripts
--
require 'src/Background'
require 'src/BackgroundLayer'
require 'src/Camera'
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
require 'src/states/entity/player/PlayerSwordIdleState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerSwordWalkState'

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
    ['bg_blue'] = love.graphics.newImage('assets/img/bg_blue.png'),
    ['bg_brown'] = love.graphics.newImage('assets/img/bg_brown.png'),
    ['bg_yellow'] = love.graphics.newImage('assets/img/bg_yellow.png'),

    ['cursor'] = love.graphics.newImage('assets/img/cursor.png'),

    ['player_fall-right'] = love.graphics.newImage('assets/img/player/fall-right.png'),
    ['player_fall-left'] = love.graphics.newImage('assets/img/player/fall-left.png'),

    ['player_idle-right'] = love.graphics.newImage('assets/img/player/idle-right.png'),
    ['player_idle-left'] = love.graphics.newImage('assets/img/player/idle-left.png'),

    ['player_sword-idle-right'] = love.graphics.newImage('assets/img/player/sword-idle-right.png'),
    ['player_sword-idle-left'] = love.graphics.newImage('assets/img/player/sword-idle-left.png'),

    ['player_jump-right'] = love.graphics.newImage('assets/img/player/jump-right.png'),
    ['player_jump-left'] = love.graphics.newImage('assets/img/player/jump-left.png'),

    ['player_walk-right'] = love.graphics.newImage('assets/img/player/walk-right.png'),
    ['player_walk-left'] = love.graphics.newImage('assets/img/player/walk-left.png'),

    ['player_sword-walk-right'] = love.graphics.newImage('assets/img/player/sword-walk-right.png'),
    ['player_sword-walk-left'] = love.graphics.newImage('assets/img/player/sword-walk-left.png'),
}

gGrids = {
    ['player_fall-right'] = anim8.newGrid(gTextures['player_fall-right'], 25, 32),
    ['player_fall-left'] = anim8.newGrid(gTextures['player_fall-left'], 25, 32),

    ['player_idle-right'] = anim8.newGrid(gTextures['player_idle-right'], 24, 32),
    ['player_idle-left'] = anim8.newGrid(gTextures['player_idle-left'], 24, 32),

    ['player_sword-idle-right'] = anim8.newGrid(gTextures['player_sword-idle-right'], 37, 32),
    ['player_sword-idle-left'] = anim8.newGrid(gTextures['player_sword-idle-left'], 37, 32),

    ['player_jump-right'] = anim8.newGrid(gTextures['player_jump-right'], 26, 32),
    ['player_jump-left'] = anim8.newGrid(gTextures['player_jump-left'], 26, 32),

    ['player_walk-right'] = anim8.newGrid(gTextures['player_walk-right'], 25, 32),
    ['player_walk-left'] = anim8.newGrid(gTextures['player_walk-left'], 25, 32),

    ['player_sword-walk-right'] = anim8.newGrid(gTextures['player_sword-walk-right'], 39, 32),
    ['player_sword-walk-left'] = anim8.newGrid(gTextures['player_sword-walk-left'], 39, 32),
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
