PlayerJumpState = Class{__includes = PlayerBaseState}

function PlayerJumpState:update(dt)
    PlayerBaseState.update(self, dt)

    -- vy >= 0 means that the player is going downwards
    if self.vy >= 0 then
        self.entity:changeState('fall')

    -- If the player is still going up and the jump button
    -- was released, cut his velocity. This will make
    -- variable jump heights
    elseif p1_input:released('jump') then
        self.entity.collider:setLinearVelocity( 0, 0.5 * self.entity.dy )
    end
    
end