PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = Level{
        id = 'test'
    }
end

function PlayState:update(dt)
    if p1_input:pressed('start') then
        gStateStack:push(PauseState())
    end

    if p1_input:pressed('main_action') then
        if self.level.player.holding == NOTHING then
            self.level.player.holding = SWORD
            self.level.player.isHolding = true
        else
            self.level.player.holding = NOTHING
            self.level.player.isHolding = false
        end
    end
    
    self.level:update(dt)
end

function PlayState:render()
    self.level:render()
end