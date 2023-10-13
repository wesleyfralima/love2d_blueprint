--
-- libraries
--
anim8 = require 'assets/lib/anim8'
baton = require 'assets/lib/baton'
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
require 'src/Background'
require 'src/BackgroundLayer'
require 'src/constants'
require 'src/Hitbox'
require 'src/StateMachine'
require 'src/utils'

require 'src/entity/entity_defs'
require 'src/entity/Entity'

require 'src/entity/enemys/PinkyStar'

require 'src/entity/player/Player'

require 'src/gui/Menu'
require 'src/gui/Panel'
require 'src/gui/Selection'

require 'src/HUD/Bar'
require 'src/HUD/HUD'

require 'src/states/BaseState'

require 'src/states/BaseSettingsState'
require 'src/states/StateStack'

require 'src/states/entity/EntityBaseState'

require 'src/states/entity/enemys/EnemyBaseState'

require 'src/states/entity/player/PlayerBaseState'

require 'src/states/entity/enemys/pinky_star/PinkyStarFallState'
require 'src/states/entity/enemys/pinky_star/PinkyStarIdleState'
require 'src/states/entity/enemys/pinky_star/PinkyStarJumpState'
require 'src/states/entity/enemys/pinky_star/PinkyStarWalkState'

require 'src/states/entity/player/PlayerFallState'
require 'src/states/entity/player/PlayerHurtState'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerLandState'
require 'src/states/entity/player/PlayerSwordAttackState'
require 'src/states/entity/player/PlayerWalkState'

require 'src/states/game/PauseState'
require 'src/states/game/SettingsState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

require 'src/states/settings/ControlsSettingsState'

require 'src/world/Level'
require 'src/world/level_defs'


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
        back            = {'key:backspace', 'button:b'},

        -- movement input
        left            = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right           = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up              = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down            = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},

        -- actions input
        main_action     = {'axis:triggerright+', 'mouse:1'},
        side_action     = {'axis:triggerleft+', 'mouse:2'},
        jump            = {'key:space', 'button:a'},
        attack          = {'key:z', 'button:x'}
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
    ['HUD'] = {
        ['heart'] = love.graphics.newImage('assets/img/HUD/heart.png'),
        ['skull'] = love.graphics.newImage('assets/img/HUD/skull.png'),
        ['bar'] = love.graphics.newImage('assets/img/HUD/bar.png'),
    },

    ['bg_blue'] = love.graphics.newImage('assets/img/bg_blue.png'),
    ['bg_brown'] = love.graphics.newImage('assets/img/bg_brown.png'),
    ['bg_yellow'] = love.graphics.newImage('assets/img/bg_yellow.png'),

    ['cursor'] = love.graphics.newImage('assets/img/cursor.png'),

    ['pinkyStar'] = {
        ['idle'] = {
            love.graphics.newImage('assets/img/pinkyStar/idle-right.png'),
            love.graphics.newImage('assets/img/pinkyStar/idle-left.png'),
        },
    },

    ['player'] = {
        ['attack'] = { 
            love.graphics.newImage('assets/img/player/sword-attack1-right.png'),
            love.graphics.newImage('assets/img/player/sword-attack1-left.png'),
            love.graphics.newImage('assets/img/player/sword-attack1-right.png'),
            love.graphics.newImage('assets/img/player/sword-attack1-left.png'),
        },
        ['fall'] = { 
            love.graphics.newImage('assets/img/player/fall-right.png'),
            love.graphics.newImage('assets/img/player/fall-left.png'),
            love.graphics.newImage('assets/img/player/sword-fall-right.png'),
            love.graphics.newImage('assets/img/player/sword-fall-left.png')
        },
        ['hurt'] = { 
            love.graphics.newImage('assets/img/player/hurt-right.png'),
            love.graphics.newImage('assets/img/player/hurt-left.png'),
            love.graphics.newImage('assets/img/player/sword-hurt-right.png'),
            love.graphics.newImage('assets/img/player/sword-hurt-left.png')
        },
        ['idle'] = {
            love.graphics.newImage('assets/img/player/idle-right.png'),
            love.graphics.newImage('assets/img/player/idle-left.png'),
            love.graphics.newImage('assets/img/player/sword-idle-right.png'),
            love.graphics.newImage('assets/img/player/sword-idle-left.png'),
        },
        ['jump'] = {
            love.graphics.newImage('assets/img/player/jump-right.png'),
            love.graphics.newImage('assets/img/player/jump-left.png'),
            love.graphics.newImage('assets/img/player/sword-jump-right.png'),
            love.graphics.newImage('assets/img/player/sword-jump-left.png'),
        },
        ['land'] = { 
            love.graphics.newImage('assets/img/player/ground-right.png'),
            love.graphics.newImage('assets/img/player/ground-left.png'),
            love.graphics.newImage('assets/img/player/sword-ground-right.png'),
            love.graphics.newImage('assets/img/player/sword-ground-left.png')
        },
        ['walk'] = {
            love.graphics.newImage('assets/img/player/walk-right.png'),
            love.graphics.newImage('assets/img/player/walk-left.png'),
            love.graphics.newImage('assets/img/player/sword-walk-right.png'),
            love.graphics.newImage('assets/img/player/sword-walk-left.png'),
        }
    }
}

gGrids = {
    ['pinkyStar'] = {
        ['idle'] = anim8.newGrid(gTextures['pinkyStar']['idle'][1], PLAYER_IMAGE_SIZE, PLAYER_IMAGE_SIZE),
    },

    ['player'] = {
        ['attack'] = anim8.newGrid(gTextures['player']['attack'][1], PLAYER_IMAGE_SIZE, PLAYER_IMAGE_SIZE),
        ['fall'] = anim8.newGrid(gTextures['player']['fall'][1], PLAYER_IMAGE_SIZE, PLAYER_IMAGE_SIZE),
        ['hurt'] = anim8.newGrid(gTextures['player']['hurt'][1], PLAYER_IMAGE_SIZE, PLAYER_IMAGE_SIZE),
        ['idle'] = anim8.newGrid(gTextures['player']['idle'][1], PLAYER_IMAGE_SIZE, PLAYER_IMAGE_SIZE),
        ['jump'] = anim8.newGrid(gTextures['player']['jump'][1], PLAYER_IMAGE_SIZE, PLAYER_IMAGE_SIZE),
        ['land'] = anim8.newGrid(gTextures['player']['land'][1], PLAYER_IMAGE_SIZE, PLAYER_IMAGE_SIZE),
        ['walk'] = anim8.newGrid(gTextures['player']['walk'][1], PLAYER_IMAGE_SIZE, PLAYER_IMAGE_SIZE),
    }
}

-- choose color according to game colors and style. Placeholder only
-- from coolors.co ()
gColors = {
    ['White'] = {255/255, 255/255, 255/255, 255/255},
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
