Entity = Class{}

function Entity:init(def)
    self.animations = self:createAnimations(def.animations)

    self.x = def.x
    self.y = def.y

    self.width = def.width
    self.height = def.height

    self.direction = 'right'
    
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture,
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

--[[
    Called when we interact with this entity, as by pressing enter.
]]
function Entity:onInteract()
    
end

function Entity:changeDirection(direction)
    --self.x = self.x + (self.width - 5) * self.direction
    self.direction = direction
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:update(dt)
    self.currentAnimation:update(dt)
    self.stateMachine:update(dt)
end

function Entity:render()
    self.stateMachine:render()
end