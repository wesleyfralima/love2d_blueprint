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

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/game/PauseState'
require 'src/states/game/StartState'



--
-- variables
--

p1_input = baton.new {
    controls = {
        start = {'key:p', 'button:start'},
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
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