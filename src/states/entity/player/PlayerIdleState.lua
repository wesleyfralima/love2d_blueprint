PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)

    if p1_input:down('right') and p1_input:down('left') then
        self.entity.direction = 'right'
        
    elseif p1_input:down('right') then
        self.entity.direction = 'right'
        self.entity:changeState('walk')

    elseif p1_input:down('left') then
        self.entity.direction = 'left'
        self.entity:changeState('walk')
    end

end