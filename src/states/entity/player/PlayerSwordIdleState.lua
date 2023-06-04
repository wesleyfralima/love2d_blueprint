PlayerSwordIdleState = Class{__includes = EntityBaseState}

function PlayerSwordIdleState:update(dt)

    local x, y = p1_input:get('move')

    if x ~= 0 then
        self.entity:changeState('sword-walk')
    end

    if p1_input:pressed('jump') then
        self.entity.collider:applyLinearImpulse( 0, self.entity.dy )
        --self.entity:changeState('jump')
    end

end