PlayerFallState = Class{__includes = EntityBaseState}

function PlayerFallState:enter()
    EntityBaseState.enter(self)
    self.entity.initialY = self.entity.y
end

function PlayerFallState:update(dt)
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    if self.entity.y > (self.entity.initialY + self.entity.jumpMaxHeight) then
        self.entity:changeState('idle')
    end

    local x, y = p1_input:get('move')
    x, y = self.entity:processMovement(x, y)

    self:assertRightXAndDirection(x)
end