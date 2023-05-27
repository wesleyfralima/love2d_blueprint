PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2
end

function PauseState:update(dt)
    if p1_input:pressed('start') then
        gStateStack:pop()
    end
end

function PauseState:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts.huge)
    love.graphics.print('PAUSED', self.x - 128, self.y - 32)
end