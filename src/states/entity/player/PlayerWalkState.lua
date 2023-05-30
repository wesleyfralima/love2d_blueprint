PlayerWalkState = Class{__includes = EntityBaseState}

function PlayerWalkState:update(dt)
    
    local x, y = p1_input:get('move')

    if x == 0 then 
        self.entity:changeState('idle')
    end

    self:assertRightXAndDirection(x, self.entity.direction)

    self.entity:processMovement(x, y)

    if p1_input:pressed('jump') then
        self.entity:changeState('jump')
    end

end