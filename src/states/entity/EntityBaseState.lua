EntityBaseState = Class{}

function EntityBaseState:exit() end
function EntityBaseState:processAI(params, dt) end
function EntityBaseState:update(dt) end

function EntityBaseState:init(entity, name)
    self.entity = entity
    self.name = name
end

function EntityBaseState:enter()
    self.animationsOnState = {
        [self.name .. '-right'] = self.entity.animations[self.name .. '-right'],
        [self.name .. '-left'] = self.entity.animations[self.name .. '-left']
    }
    self.entity:changeAnimation(self.animationsOnState[self.name .. '-' .. self.entity.direction])
end

function EntityBaseState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
end