PlayerSwordAttackState = Class{__includes = PlayerBaseState}

function PlayerSwordAttackState:init(entity, name, enemys)
    PlayerBaseState.init(self, entity, name)

    -- This hitbox will damage foes and objects
    self.hitbox = self.entity:rangeBox(15)

    -- Must keep track of enemys to damage them
    self.enemys = enemys
end

function PlayerSwordAttackState:update(dt)
    PlayerBaseState.update(self, dt)

    -- If player presses attack button again,
    -- a combo will be performed
    if p1_input:pressed('attack') then
        print('second sword')
    end

    -- check if hitbox collides with any enemys in the level
    for _, enemy in pairs(self.enemys) do
        if enemy.hurtBox:collided(self.hitbox) and not enemy.invulnerable then
            enemy:damage(1)
            enemy:goInvulnerable(1)
            -- gSounds['hit-enemy']:play()
        end
    end

    -- if we've fully elapsed through one cycle of animation,
    -- change back to idle state. This is possible because
    -- this anim is set to pause on end
    if self.entity.currentAnimation.status == 'paused' then
        self.entity:changeState('idle')
    end
    
end