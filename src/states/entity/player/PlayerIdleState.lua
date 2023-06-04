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

    if self.entity.isHolding then
        if self.entity.holding == SWORD then

            if p1_input:pressed('attack') then
                print('sword slash')
            end
        end
    end
    
end