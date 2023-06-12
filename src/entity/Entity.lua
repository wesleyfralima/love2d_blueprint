Entity = Class{}

function Entity:init(def)
    self.type = def.type

    self.animations = self:createAnimations(ENTITY_DEFS[self.type].animations)
    self.animationsOnState = {}

    self.width = def.width
    self.height = def.height

    self.health = def.health or 5
    self.maxHealth = def.maxHealth or 5

    self.direction = def.direction

    self.holding = def.holding or NOTHING
    
    if self.holding == NOTHING then
        self.isHolding = false
    else
        self.isHolding = true
    end

    self.dx = def.dx
    self.dy = def.dy

    -- physics
    self.collider = def.collider
    self.collider:setFixedRotation(true)
    self.collider:setFriction(0)

    self.isOnGround = nil

    self.hurtBox = Hitbox(0, 0, self.width, self.height)

    -- flags for flashing the entity when hit
    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0

    -- timer for turning transparency on and off, flashing
    self.flashTimer = 0

    self.dead = false

    self.onDeath = def.onDeath or function() end

    self.isHurting = false
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for i, animationDef in pairs(animations) do
        animationsReturned[i] = {}
        for j = 1, 4 do
            animationsReturned[i][j] = anim8.newAnimation(
                gGrids[self.type][i](
                    animationDef.framesCol,
                    1 -- row is always one
                ),
                animationDef.interval,
                animationDef.onloop
            )
        end
    end
    return animationsReturned
end

function Entity:createAnimationsOnState(stateName)
    local animationsReturned = {}

    for state, anims in pairs(self.animations) do
        if stateName == state then

            for index, anim in pairs(anims) do
                animationsReturned[index] = anim
            end

            return animationsReturned
        end
    end
end

function Entity:changeAnimation(animation)
    self.currentAnimation = animation
end

function Entity:changeAnimationOnState(index)
    self.currentAnimation = self.animationsOnState[index]
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeDirection(x)
    if x < 0 then
        self.direction = LEFT
    elseif x > 0 then
        self.direction = RIGHT
    end
end

function Entity:heal(dmg)
    self.health = math.min(self.health + dmg, self.maxHealth)
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end

--[[
    Called when we interact with this entity, as by pressing
    interact key (defined in Dependencies.lua).
]]
function Entity:onInteract()
    
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:update(dt)
    local x, y = self.collider:getPosition()

    self.x = x - PLAYER_IMAGE_SIZE/2
    self.y = y - 2*PLAYER_IMAGE_SIZE/3 + self.height/2

    self.hurtBox:setPosition(x - self.width/2, y - self.height/2)

    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end

    for _, anim in pairs(self.animationsOnState) do
        anim:update(dt)
    end

    self.stateMachine:update(dt)
end

function Entity:render()
    
    -- draw sprite slightly transparent if invulnerable every 0.04 seconds
    if self.invulnerable and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setColor(1, 1, 1, 64/255)
    end

    self.stateMachine:render()
    love.graphics.setColor(1, 1, 1, 1)
end