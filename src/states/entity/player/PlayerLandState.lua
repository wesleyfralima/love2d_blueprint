PlayerLandState = Class{__includes = PlayerBaseState}

function PlayerLandState:update(dt)
    PlayerBaseState.update(self, dt)

    -- If the animation was played once, change state
    if self.entity.currentAnimation.status == 'paused' then
        self.entity:changeState('idle')
    end

end