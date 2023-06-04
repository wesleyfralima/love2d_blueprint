PlayerSwordWalkState = Class{__includes = EntityBaseState}

function PlayerSwordWalkState:update(dt)

    local x, _ = p1_input:get('move')
    self:assertRightXAndDirection(x)
    self.entity:processXMovement(x)

    if x == 0 then 
        self.entity:changeState('sword-idle')
    end

    if p1_input:pressed('jump') then
        self.entity.collider:applyLinearImpulse( 0, self.entity.dy )
        --self.entity:changeState('jump')
    end
    
end