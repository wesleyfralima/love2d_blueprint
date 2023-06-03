Level = Class{}

function Level:init(player, defs)

    self.world = wf.newWorld(0, 1000)

    local collider = self.world:newRectangleCollider(
        VIRTUAL_WIDTH / 2 + 3,
        VIRTUAL_HEIGHT / 2,
        18,
        20
    )

    collider:setFriction(0)

    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        x = 0,
        y = 0,
        width = 24,
        height = 32,
        direction = 'right',
        dx = 150,
        dy = PLAYER_JUMP_IMPULSE,
        collider = collider,
        colliderHeightDifference = 5
    }

    self.player.jumpMaxHeight = self.player.height * 2

    self.player.stateMachine = StateMachine {
        ['fall'] = function() return PlayerFallState(self.player, 'fall') end,
        ['idle'] = function() return PlayerIdleState(self.player, 'idle') end,
        ['jump'] = function() return PlayerJumpState(self.player, 'jump') end,
        ['walk'] = function() return PlayerWalkState(self.player, 'walk') end,
    }

    self.map = sti('assets/tiled/maps/test_map.lua')    

    self.walls = {}

    for i, obj in pairs(self.map.objects) do
        local wall = self.world:newRectangleCollider(
            obj.x,
            obj.y,
            obj.width,
            obj.height
        )
        wall:setType('static')
        table.insert(self.walls, wall)
    end

    self.camera = Camera{
        windowWidth = VIRTUAL_WIDTH,
        windowHeight = VIRTUAL_HEIGHT,
        following = self.player
    }

    self.player.stateMachine:change('idle')

    local bg1 = BackgroundLayer{
        xSpeed = 60,
        ySpeed = 5,
        image = gTextures['bg_yellow'],
        y = 300,
    }

    local bg2 = BackgroundLayer{
        xSpeed = 100,
        ySpeed = 10,
        image = gTextures['bg_brown'],
        y = 450,
    }

    local bg3 = BackgroundLayer{
        xSpeed = 150,
        ySpeed = 15,
        image = gTextures['bg_blue'],
        y = 500,
    }

    self.background = Background{
        layers = {bg1, bg2, bg3}
    }
end

function Level:update(dt)
    self.world:update(dt)
    self.player:update(dt)
    self.camera:update(dt)
    self.background:update(dt)
end

function Level:render()
    self.camera:startFilming()

        self.background:render()
        self.map:drawLayer(self.map.layers['ground'])
        self.player:render()

        -- this draws the colliders
        -- self.world:draw()

        -- this draws a box containing the player
        -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)

    self.camera:stopFilming()
end