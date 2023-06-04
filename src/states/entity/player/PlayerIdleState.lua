PlayerIdleState = Class{__includes = EntityBaseState}

function PlayerIdleState:update(dt)

    local x, y = p1_input:get('move')

    if x ~= 0 then
        self.entity:changeState('walk')
    end

    if p1_input:pressed('jump') then
        self.entity.collider:applyLinearImpulse( 0, self.entity.dy )
        self.entity:changeState('jump')
    end

    if p1_input:pressed('main_action') then
        self.entity.holding = SWORD
        --self:enter()
    end

end