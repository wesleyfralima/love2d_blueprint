Level = Class{}

function Level:init(def)
    local levelInfo = require ('src/world/levels/level_' .. def.id)

    self:createBackground(levelInfo.backgrounds)

    self:createWorld(levelInfo.gravity)

    self:createMap(levelInfo.map)

    self:createPlayer(levelInfo.player)

    self.camera = gamera.new(
        0,
        0,
        10000,
        10000
    )

    self.camera:setWindow(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    self.enemys = {}
    self:createEnemys(levelInfo.enemys)

end

function Level:update(dt)
    self.world:update(dt)
    self.player:update(dt)

    for i, enemy in pairs(self.enemys) do
        enemy:update(dt)
    end

    self.camera:setPosition(self.player.x, self.player.y)
    self.background:update(dt, self.player.x, self.player.y)
end

function Level:render()
    self.camera:draw(function()

        self.background:render()
        self.map:drawLayer(self.map.layers['ground'])

        for i, enemy in pairs(self.enemys) do
            enemy:render()
        end

        self.player:render()

        -- this draws the colliders
        -- self.world:draw()

    end)
end

function Level:createWorld(info)
    self.world = wf.newWorld(
        info.x,
        info.y
    )

    self.world:addCollisionClass('Solid')
    self.world:addCollisionClass('Ground')

    self.world:addCollisionClass('Player')
    self.world:addCollisionClass('Enemy', {ignores = {'Player'}})
end

function Level:createPlayer(info)
    local collider = self.world:newRectangleCollider(
        info.x,
        info.y,
        12,
        20
    )
    collider:setCollisionClass('Player')

    self.player = Player {
        type = info.type,
        x = info.x,
        y = info.y,
        width = info.width,
        height = info.height,
        direction = info.direction,
        dx = info.dx,
        dy = info.dy,
        collider = collider,
        holding = info.holding
    }

    self.player.stateMachine = StateMachine {
        ['attack'] = function() return PlayerSwordAttackState(self.player, 'attack') end,
        ['fall'] = function() return PlayerFallState(self.player, 'fall') end,
        ['idle'] = function() return PlayerIdleState(self.player, 'idle') end,
        ['jump'] = function() return PlayerJumpState(self.player, 'jump') end,
        ['walk'] = function() return PlayerWalkState(self.player, 'walk') end,
    }

    self.player.stateMachine:change(info.state)

end

function Level:createMap(info)
    self.map = sti(info)    

    self.walls = {}

    for i, obj in pairs(self.map.objects) do
        local wall = self.world:newRectangleCollider(
            obj.x,
            obj.y,
            obj.width,
            obj.height
        )
        wall:setType('static')
        wall:setCollisionClass('Ground')
        table.insert(self.walls, wall)
    end
end

function Level:createBackground(info)
    local layer = nil
    local bgLayers = {}

    for i, bg in pairs(info) do 
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

function Level:createObjects(info)

end

function Level:createEnemys(info)
    for i, enemy in pairs(info) do

        local collider = self.world:newRectangleCollider(
            enemy.x,
            enemy.y,
            12,
            20
        )
        collider:setCollisionClass('Enemy')

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