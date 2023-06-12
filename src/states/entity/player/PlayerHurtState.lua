PlayerHurtState = Class{__includes = PlayerBaseState}

function PlayerHurtState:enter()
    PlayerBaseState.enter(self)

    local dir = self.entity.direction == RIGHT and 1 or -1

    self.entity.collider:applyLinearImpulse( dir * 0.5*self.entity.dy, -100 )

    self.entity.isHurting = true

end

function PlayerHurtState:exit()
    PlayerBaseState.exit(self)

    self.entity.isHurting = false

end

function PlayerHurtState:update(dt)
    PlayerBaseState.update(self, dt)

    -- If the animation was played once, change state
    if self.entity.currentAnimation.status == 'paused' then
        self.entity:changeState('idle')
    end
end