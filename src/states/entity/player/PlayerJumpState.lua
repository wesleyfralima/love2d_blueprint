PlayerJumpState = Class{__includes = EntityBaseState}

function PlayerJumpState:update(dt)
    local _, vy = self.entity.collider:getLinearVelocity()

    if vy >= 0 then
        self.entity:changeState('fall')
    end

    local x, y = p1_input:get('move')
    
    self.entity:processXMovement(x)
    self:assertRightXAndDirection(x)
end