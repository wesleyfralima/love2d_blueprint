PlayerFallState = Class{__includes = PlayerBaseState}

function PlayerFallState:enter()
    PlayerBaseState.enter(self)

    -- This is used so the player falls faster.
    -- It's better for the gameplay feel
    self.entity.collider:applyLinearImpulse( 0, -0.1 * self.entity.dy )
end

function PlayerFallState:update(dt)
    PlayerBaseState.update(self, dt)

    if self.entity.isOnGround then
        -- If player hit the ground and if not moving sideways,
        -- change state to land (plays a landing animation)
        if self.vx == 0 then
            self.entity:changeState('land')

        -- If player is moving sideways, change state do idle
        -- (I did this because landing while moving makes the 
        -- player looks like he is floating)        
        else
            self.entity:changeState('idle')
        end

    -- If the player is falling too fast, cap his downwards velocity
    elseif self.vy > PLAYER_MAX_FALL_SPEED then
        self.entity.collider:setLinearVelocity(0, PLAYER_MAX_FALL_SPEED)
    end
    
end