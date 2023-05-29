PlayerWalkState = Class{__includes = EntityBaseState}

function PlayerWalkState:update(dt)
    
    local x, y = p1_input:get('move')

    if x == 0 then 
        self.entity:changeState('idle')
    else
        self.entity:processMovement(x, y)
    end

    if p1_input:pressed('jump') then
        self.entity:changeState('jump')
    end

end