PlayerJumpState = Class{__includes = EntityBaseState}

function PlayerJumpState:enter()
    EntityBaseState.enter(self)
    self.entity.initialY = self.entity.y
end

function PlayerJumpState:update(dt)
    self.entity.y = self.entity.y - (self.entity.dy * dt)
    
    if self.entity.y < (self.entity.initialY - self.entity.jumpMaxHeight) then
        self.entity:changeState('fall')
    end

    local x, y = p1_input:get('move')
    x, y = self.entity:processMovement(x, y)

    self.entity.lastDirection = self.entity.direction == 'right' and 1 or -1

    if self.entity.lastDirection ~= x and x ~= 0 then
        self.entity:changeDirection()
        self.entity:changeAnimationOnState(self.name .. '-' .. self.entity.direction)
    end
end