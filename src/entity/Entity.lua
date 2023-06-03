Entity = Class{}

function Entity:init(def)
    self.animations = self:createAnimations(def.animations)
    self.animationsOnState = {}

    self.x = def.x
    self.y = def.y

    self.width = def.width
    self.height = def.height

    self.direction = def.direction

    self.dx = def.dx
    self.dy = def.dy

    self.jumpMaxHeight = def.jumpMaxHeight

    -- physics
    self.collider = def.collider
    self.collider:setFixedRotation(true)
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(animation)
    self.currentAnimation = animation
end

function Entity:changeDirection(x)
    if x < 0 then
        self.direction = 'left'
    elseif x > 0 then
        self.direction = 'right'
    end
end

function Entity:changeAnimationOnState(name)
    self.currentAnimation = self.animationsOnState[name]
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = anim8.newAnimation(
            gGrids[animationDef.texture](
                animationDef.framesCol,
                1 -- row is always one
            ), 
            animationDef.interval,
            animationDef.onloop
        )
    end

    return animationsReturned
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

    self.x = self.collider:getX() - self.width/2
    self.y = self.collider:getY() - self.height/2 -2

    for _, anim in pairs(self.animationsOnState) do
        anim:update(dt)
    end

    self.stateMachine:update(dt)
end

function Entity:render()
    self.stateMachine:render()
end