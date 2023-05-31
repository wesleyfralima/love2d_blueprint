Level = Class{}

function Level:init(player, defs)

    self.world = wf.newWorld(0, 200)

    local playerCollider = self.world:newBSGRectangleCollider(
        VIRTUAL_WIDTH / 2 + 3,
        VIRTUAL_HEIGHT / 2,
        24 - 6,
        28,
        4
    )

    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        x = VIRTUAL_WIDTH / 2,
        y = VIRTUAL_HEIGHT / 2,
        width = 24,
        height = 28,
        direction = 'right',
        dx = 75,
        dy = 100,
        collider = playerCollider
    }

    self.player.jumpMaxHeight = self.player.height * 2

    self.player.stateMachine = StateMachine {
        ['fall'] = function() return PlayerFallState(self.player, 'fall') end,
        ['idle'] = function() return PlayerIdleState(self.player, 'idle') end,
        ['jump'] = function() return PlayerJumpState(self.player, 'jump') end,
        ['walk'] = function() return PlayerWalkState(self.player, 'walk') end,
    }

    self.player.stateMachine:change('idle')

    self.ground = self.world:newRectangleCollider(
        -10,
        VIRTUAL_HEIGHT - 10,
        VIRTUAL_WIDTH + 20,
        15
    )
    self.ground:setType('static')
end

function Level:update(dt)
    self.player:update(dt)
    self.world:update(dt)
end

function Level:render()
    self.player:render()
    self.world:draw()
end