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
        anim:resume()
    end
    
    self.entity:changeAnimation(self.entity.animationsOnState[self.name .. '-' .. self.entity.direction])
end

function EntityBaseState:render()
    
    if self.entity.currentAnimation == nil then
        self.entity:changeAnimationOnState(self.name .. '-' .. self.entity.direction)
    end

    self.entity.currentAnimation:draw(gTextures['player_' .. self.name .. '-' .. self.entity.direction], 
        self.entity.x + self.entity.colliderOffsetX, 
        self.entity.y + self.entity.colliderOffsetY)
end

function EntityBaseState:assertRightXAndDirection(x)
    if x == 0 or (x < 0 and self.entity.direction == 'left') or (x > 0 and self.entity.direction == 'right') then
        return
    end
    self.entity:changeDirection(x)
    self.entity:changeAnimationOnState(self.name .. '-' .. self.entity.direction)
end
