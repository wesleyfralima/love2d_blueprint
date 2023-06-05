Entity = Class{}

function Entity:init(def)
    self.type = def.type

    self.animations = self:createAnimations(def.animations)
    self.animationsOnState = {}

    self.x = def.x
    self.y = def.y

    self.width = def.width
    self.height = def.height

    self.colliderWidthDifference = def.colliderWidthDifference or 0
    self.colliderHeightDifference = def.colliderHeightDifference or 0

    self.colliderOffsetX = 0
    self.colliderOffsetY = 0

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
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(animation)
    self.currentAnimation = animation
end

function Entity:changeDirection(x)
    if x < 0 then
        self.direction = LEFT
    elseif x > 0 then
        self.direction = RIGHT
    end
end

function Entity:changeAnimationOnState(index)
    self.currentAnimation = self.animationsOnState[index]
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for i, animationDef in pairs(animations) do
        animationsReturned[i] = {}
        for j, anim in pairs(animationDef) do
            animationsReturned[i][j] = anim8.newAnimation(
                gGrids[self.type][i][j](
                    anim.framesCol,
                    1 -- row is always one
                ),
                anim.interval,
                anim.onloop
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

function Entity:rangeBox(range)
    local x = self.x + self.width/2
    local y = self.y + self.height/2 + 6
    local width = range
    local height = 4

    if self.direction == RIGHT then
        x = x + 17
    else
        x = x - (17 + range)
    end

    return Hitbox(x, y, width, height)
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

    self.x = self.collider:getX() - self.width/2 - self.colliderWidthDifference
    self.y = self.collider:getY() - self.height/2 - self.colliderHeightDifference

    for _, anim in pairs(self.animationsOnState) do
        anim:update(dt)
    end

    self.stateMachine:update(dt)
end

function Entity:render()
    self.stateMachine:render()
end