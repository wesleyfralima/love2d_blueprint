PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)
    if p1_input:down('move') then

        self.entity:changeState('walk')

    end
end