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
require 'src/constants'
require 'src/utils'

require 'src/gui/Menu'
require 'src/gui/Panel'
require 'src/gui/Selection'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/game/PauseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'



--
-- variables
--

p1_input = baton.new {
    controls = {
        -- options input
        start = {'key:p', 'button:start'},
        escape = {'key:escape'},

        -- menu related input
        interact = {'key:return', 'button:a'},

        -- movement input
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},

        -- actions input
        main_action = {'key:space', 'axis:triggerright+', 'mouse:1'},
        side_action = {'key:return', 'axis:triggerleft+', 'mouse:2'}
    },
    pairs = {
        move = {'left', 'right', 'up', 'down'}
    },
    joystick = love.joystick.getJoysticks()[1],
    deadzone = 0.35
}

gFonts = {
    small = love.graphics.newFont('assets/fonts/font.ttf', 8),
    medium = love.graphics.newFont('assets/fonts/font.ttf', 16),
    big = love.graphics.newFont('assets/fonts/font.ttf', 32),
    huge = love.graphics.newFont('assets/fonts/font.ttf', 64),
}

gTextures = {
    ['cursor'] = love.graphics.newImage('assets/img/cursor.png'),
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