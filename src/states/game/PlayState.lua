PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.points = 0
    self.pointsText = nil
    self.pointsPerAct = 1

    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT - 60,
        width = 28,
        height = 24,
        direction = 'right',
        dx = 75,
        dy = 150,
    }

    self.player.jumpMaxHeight = self.player.height * 1.5


    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['jump'] = function() return PlayerJumpState(self.player) end,
        ['walk'] = function() return PlayerWalkState(self.player) end,
    }
    self.player.stateMachine:change('idle')

end

function PlayState:update(dt)
    if p1_input:pressed('start') then
        gStateStack:push(PauseState())
    end
    
    if p1_input:pressed('main_action') then
        self.points = self.points + self.pointsPerAct
    end

    if p1_input:pressed('side_action') then
        self.points = self.points - self.pointsPerAct
    end

    self.player:update(dt)
end

function PlayState:render()
    self.player:render()
end