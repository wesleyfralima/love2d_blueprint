EntityBaseState = Class{}

function EntityBaseState:exit() end
function EntityBaseState:processAI(params, dt) end
function EntityBaseState:update(dt) end

function EntityBaseState:init(entity, name)
    self.entity = entity
    self.name = name

    self.rightAnimName = self.name .. '-right'
    self.leftAnimName = self.name .. '-left'
end

function EntityBaseState:enter()
    self.entity.animationsOnState = {
        [self.rightAnimName] = self.entity.animations[self.rightAnimName],
        [self.leftAnimName] = self.entity.animations[self.leftAnimName]
    }

    for _, anim in pairs(self.entity.animationsOnState) do
        anim:refresh()
    end
    
    self.entity:changeAnimation(self.entity.animationsOnState[self.name .. '-' .. self.entity.direction])
end

function EntityBaseState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
end