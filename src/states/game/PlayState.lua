PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = Level()
end

function PlayState:update(dt)
    if p1_input:pressed('start') then
        gStateStack:push(PauseState())
    end
    
    self.level:update(dt)
end

function PlayState:render()
    self.level:render()
end