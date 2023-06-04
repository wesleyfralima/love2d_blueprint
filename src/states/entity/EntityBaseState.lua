EntityBaseState = Class{}

function EntityBaseState:exit() end
function EntityBaseState:processAI(params, dt) end
function EntityBaseState:update(dt) end

function EntityBaseState:init(entity, name)
    self.entity = entity
    self.name = name
end

function EntityBaseState:enter()

    self.entity.animationsOnState = self.entity:createAnimationsOnState(self.name)

    for _, anim in pairs(self.entity.animationsOnState) do
        anim:resume()
    end
    
    self.entity:changeAnimation(self.entity.animationsOnState[self.entity.direction + self.entity.holding])
end

function EntityBaseState:render()
    
    if self.entity.currentAnimation == nil then
        self.entity:changeAnimationOnState(self.entity.direction + self.entity.holding)
    end

    self.entity.currentAnimation:draw(gTextures[self.entity.type][self.name][self.entity.holding + self.entity.direction], 
        self.entity.x, 
        self.entity.y)
end

function EntityBaseState:assertRightXAndDirection(x)
    if x == 0 or (x < 0 and self.entity.direction == LEFT) or (x > 0 and self.entity.direction == RIGHT) then
        return
    end
    self.entity:changeDirection(x)
    self.entity:changeAnimationOnState(self.entity.direction + self.entity.holding)
end
