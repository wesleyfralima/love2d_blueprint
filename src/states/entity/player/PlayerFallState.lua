PlayerFallState = Class{__includes = EntityBaseState}

function PlayerFallState:enter()
    EntityBaseState.enter(self)
    self.entity.collider:applyLinearImpulse( 0, -0.1 * self.entity.dy )
end

function PlayerFallState:update(dt)
    local _, vy = self.entity.collider:getLinearVelocity()

    if vy == 0 then
        self.entity:changeState('idle')
    elseif vy > PLAYER_MAX_FALL_SPEED then
        self.entity.collider:setLinearVelocity(0, PLAYER_MAX_FALL_SPEED)
    end

    local x, y = p1_input:get('move')
    
    self.entity:processXMovement(x)
    self:assertRightXAndDirection(x)

    if self.entity.isHolding then
        if self.entity.holding == SWORD then

            if p1_input:pressed('attack') then
                print('sword slash')
            end
        end
    end

end