Level = Class{}

function Level:init(player, defs)

    self.world = wf.newWorld(0, 200)

    local collider = self.world:newBSGRectangleCollider(
        VIRTUAL_WIDTH / 2 + 3,
        VIRTUAL_HEIGHT / 2,
        24 - 6,
        20,
        4
    )

    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        x = VIRTUAL_WIDTH / 2 + 3,
        y = VIRTUAL_HEIGHT / 2,
        width = 24,
        height = 28,
        direction = 'right',
        dx = 150,
        dy = PLAYER_JUMP_IMPULSE,
        collider = collider
    }

    self.player.jumpMaxHeight = self.player.height * 2

    self.player.stateMachine = StateMachine {
        ['fall'] = function() return PlayerFallState(self.player, 'fall') end,
        ['idle'] = function() return PlayerIdleState(self.player, 'idle') end,
        ['jump'] = function() return PlayerJumpState(self.player, 'jump') end,
        ['walk'] = function() return PlayerWalkState(self.player, 'walk') end,
    }

    self.ground = self.world:newRectangleCollider(
        -10,
        VIRTUAL_HEIGHT - 50,
        VIRTUAL_WIDTH + 20,
        15
    )
    self.ground:setType('static')

    self.player.stateMachine:change('idle')
end

function Level:update(dt)
    self.world:update(dt)
    self.player:update(dt)

    self.player.x = self.player.collider:getX() - self.player.width/2
    self.player.y = self.player.collider:getY() - self.player.height/2 - 4
end

function Level:render()
    self.player:render()
    -- self.world:draw()
end