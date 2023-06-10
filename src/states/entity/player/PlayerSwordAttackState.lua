PlayerSwordAttackState = Class{__includes = PlayerBaseState}

function PlayerSwordAttackState:enter()
    PlayerBaseState.enter(self)

    -- This hitbox will damage foes and objects
    self.entity.hitbox = self.entity:rangeBox(15)
end

function PlayerSwordAttackState:exit()
    PlayerBaseState.exit(self)

    -- Hitbox must be destroyed when attack is done
    self.entity.hitbox = nil
end

function PlayerSwordAttackState:update(dt)
    PlayerBaseState.update(self, dt)

    -- If player presses attack button again,
    -- a combo will be performed
    if p1_input:pressed('attack') then
        print('second sword')
    end

    -- if we've fully elapsed through one cycle of animation,
    -- change back to idle state. This is possible because
    -- this anim is set to pause on end
    if self.entity.currentAnimation.status == 'paused' then
        self.entity:changeState('idle')
    end
    
end