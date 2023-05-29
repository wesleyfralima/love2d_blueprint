PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:update(dt)

    -- this anim change is here only because of the bug where player
    -- moonwalks sometimes when keys are pressed too close to one another
    self.entity:changeAnimation('walk-'..self.entity.direction)
    
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