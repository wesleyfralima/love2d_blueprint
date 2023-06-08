Level = Class{}

function Level:init(def)
    local levelInfo = require ('src/world/levels/level_' .. def.id)

    self:createBackground(levelInfo)

    self.world = wf.newWorld(
        levelInfo.gravity.x,
        levelInfo.gravity.y
    )

    self:createMap(levelInfo)

    self:createPlayer(levelInfo)

    self.camera = Camera{
        windowWidth = VIRTUAL_WIDTH,
        windowHeight = VIRTUAL_HEIGHT,
        following = self.player
    }

    self.enemys = {}
    self:createEnemys(levelInfo.enemys)

end

function Level:update(dt)
    self.world:update(dt)
    self.player:update(dt)

    for i, enemy in pairs(self.enemys) do
        enemy:update(dt)
    end

    self.camera:update(dt)
    self.background:update(dt, self.player.x, self.player.y)
end

function Level:render()
    self.camera:startFilming()

        self.background:render()
        self.map:drawLayer(self.map.layers['ground'])

        for i, enemy in pairs(self.enemys) do
            enemy:render()
        end

        self.player:render()

        -- this draws the colliders
        -- self.world:draw()

        -- this draws a box containing the player
        -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)

    self.camera:stopFilming()
end

function Level:createPlayer(levelInfo)

    local pInfo = levelInfo['player']

    local collider = self.world:newRectangleCollider(
        pInfo.x,
        pInfo.y,
        12,
        20
    )

    self.player = Player {
        type = pInfo.type,
        animations = ENTITY_DEFS[pInfo.type].animations,
        x = pInfo.x,
        y = pInfo.y,
        width = pInfo.width,
        height = pInfo.height,
        direction = pInfo.direction,
        dx = pInfo.dx,
        dy = pInfo.dy,
        collider = collider,
        colliderHeightDifference = pInfo.colliderHeightDifference,
        holding = pInfo.holding
    }

    self.player.stateMachine = StateMachine {
        ['attack'] = function() return PlayerSwordAttackState(self.player, 'attack') end,
        ['fall'] = function() return PlayerFallState(self.player, 'fall') end,
        ['idle'] = function() return PlayerIdleState(self.player, 'idle') end,
        ['jump'] = function() return PlayerJumpState(self.player, 'jump') end,
        ['walk'] = function() return PlayerWalkState(self.player, 'walk') end,
    }

    self.player.stateMachine:change(pInfo.state)

end

function Level:createMap(levelInfo)
    local mapInfo = levelInfo['map']

    self.map = sti(mapInfo)    

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
end

function Level:createBackground(levelInfo)
    local bgInfo = levelInfo['backgrounds']
    local layer = nil
    local bgLayers = {}

    for i, bg in pairs(bgInfo) do 
        layer = BackgroundLayer{
            xSpeed = bg.xSpeed,
            ySpeed = bg.ySpeed,
            image = bg.image,
            x = bg.x,
            y = bg.y,
        }

        table.insert(bgLayers, layer)
    end
    
    self.background = Background{
        layers = bgLayers
    }
end

function Level:createObjects(levelInfo)

end

function Level:createEnemys(info)
    for i, enemy in pairs(info) do

        local collider = self.world:newRectangleCollider(
            enemy.x,
            enemy.y,
            12,
            20
        )

        local e = PinkyStar{
            type = enemy.type,
            animations = ENTITY_DEFS[enemy.type].animations,
            x = enemy.x,
            y = enemy.y,
            width = enemy.width,
            height = enemy.height,
            direction = enemy.direction,
            dx = enemy.dx,
            dy = enemy.dy,
            collider = collider,
            colliderHeightDifference = enemy.colliderHeightDifference,
        }

        e.stateMachine = StateMachine {
            ['idle'] = function() return EntityIdleState(e, 'idle') end,
        }
    
        e.stateMachine:change(enemy.state)

        table.insert(self.enemys, e)
    end
end