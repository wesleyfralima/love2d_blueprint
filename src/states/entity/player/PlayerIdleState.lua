PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)

    if p1_input:down('right') and p1_input:down('left') then
        -- do nothing
        
    elseif p1_input:down('right') then
        self.entity.direction = 'right'
        self.entity:changeState('walk')

    elseif p1_input:down('left') then
        self.entity.direction = 'left'
        self.entity:changeState('walk')
    end

    if p1_input:pressed('jump') then
        self.entity:changeState('jump')
    end

end