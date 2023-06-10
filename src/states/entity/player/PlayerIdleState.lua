PlayerIdleState = Class{__includes = PlayerBaseState}

function PlayerIdleState:update(dt)
    PlayerBaseState.update(self, dt)

    -- If the button for walking was pressed, player must walk
    if self.inputX ~= 0 then
        self.entity:changeState('walk')
    end
    
end