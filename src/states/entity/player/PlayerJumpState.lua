PlayerJumpState = Class{__includes = EntityBaseState}

function PlayerJumpState:update(dt)
    local _, vy = self.entity.collider:getLinearVelocity()

    if vy >= 0 then
        self.entity:changeState('fall')
    elseif p1_input:released('jump') then
        self.entity.collider:setLinearVelocity( 0, 0.5 * self.entity.dy )
    end

    local x, y = p1_input:get('move')
    
    self.entity:processXMovement(x)
    self:assertRightXAndDirection(x)
end