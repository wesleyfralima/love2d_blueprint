PlayerSwordAttackState = Class{__includes = EntityBaseState}

function PlayerSwordAttackState:update(dt)

    local x, y = p1_input:get('move')

    if p1_input:pressed('attack') then
        print('second sword')
    end

    if p1_input:pressed('jump') then
        self.entity.collider:applyLinearImpulse( 0, self.entity.dy )
        self.entity:changeState('jump')
    end

    -- if we've fully elapsed through one cycle of animation,
    -- change back to idle state. This is possible because
    -- this anim is set to pause on end
    if self.entity.currentAnimation.status == 'paused' then
        self.entity:changeState('idle')
    end

    self.entity:processXMovement(x)
    self:assertRightXAndDirection(x)
    
end