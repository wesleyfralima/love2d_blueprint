PlayerFallState = Class{__includes = EntityBaseState}

function PlayerFallState:enter()
    EntityBaseState.enter(self)
    self:processYMovement()
end

function PlayerFallState:update(dt)
    local _, vy = self.entity.collider:getLinearVelocity()

    if vy == 0 then
        self.entity:changeState('idle')
    end

    local x, y = p1_input:get('move')
    
    self.entity:processXMovement(x)
    self:assertRightXAndDirection(x)
end