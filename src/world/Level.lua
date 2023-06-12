Level = Class{}

function Level:init(def)
    local levelInfo = require (LEVELS[def.id])

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

    for i = #self.enemys, 1, -1 do
        local enemy = self.enemys[i]

        -- remove entity from the table if health is <= 0
        if enemy.health <= 0 then
            enemy.dead = true
            enemy.onDeath()
            -- collider must always be removed
            enemy.collider:destroy()
            table.remove(self.enemys, i)

            -- If enemy is dead, no need to go further
            return
        end

        enemy:processAI({}, dt)
        enemy:update(dt)

        -- collision between the player and entities in the room
        if enemy.hurtBox:collided(self.player.hurtBox) and not self.player.invulnerable then
            self.player:changeState('hurt')
            --gSounds['hit-player']:play()
            self.player:damage(1)
            self.player:goInvulnerable(1.5)

            if self.player.health <= 0 then
                -- self.player.collider:destroy()
                print('Player is dead')
            end
        end
    end

    self.camera:setPosition(
        self.player.x + PLAYER_IMAGE_SIZE/2,
        self.player.y + PLAYER_IMAGE_SIZE/5
    )

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
        info.width,
        info.height
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
        holding = info.holding,
    }

    self.player.stateMachine = StateMachine {
        ['attack'] = function() return PlayerSwordAttackState(self.player, 'attack', self.enemys) end,
        ['fall'] = function() return PlayerFallState(self.player, 'fall') end,
        ['hurt'] = function() return PlayerHurtState(self.player, 'hurt') end,
        ['idle'] = function() return PlayerIdleState(self.player, 'idle') end,
        ['jump'] = function() return PlayerJumpState(self.player, 'jump') end,
        ['land'] = function() return PlayerLandState(self.player, 'land') end,
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
            enemy.width,
            enemy.height
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
        }

        e.stateMachine = StateMachine {
            ['idle'] = function() return EntityBaseState(e, 'idle') end,
        }
    
        e.stateMachine:change(enemy.state)

        table.insert(self.enemys, e)
    end
end