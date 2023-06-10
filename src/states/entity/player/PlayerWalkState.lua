PlayerWalkState = Class{__includes = PlayerBaseState}

function PlayerWalkState:update(dt)
    PlayerBaseState.update(self, dt)
    
    -- If no moviment buttons was pressed, player must stop
    if self.inputX == 0 then 
        self.entity:changeState('idle')
    end
    
end