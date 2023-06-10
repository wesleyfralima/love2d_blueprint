PlayerFallState = Class{__includes = EntityBaseState}

function PlayerFallState:enter()
    EntityBaseState.enter(self)
    self.entity.collider:applyLinearImpulse( 0, -0.1 * self.entity.dy )
end

function PlayerFallState:update(dt)
    local vx, vy = self.entity.collider:getLinearVelocity()

    if vy == 0 and vx ~= 0 then
        self.entity:changeState('idle')
    elseif vy == 0 then
        self.entity:changeState('land')
    elseif vy > PLAYER_MAX_FALL_SPEED then
        self.entity.collider:setLinearVelocity(0, PLAYER_MAX_FALL_SPEED)
    end

    local x, y = p1_input:get('move')
    
    self.entity:processXMovement(x)
    self:assertRightXAndDirection(x)

    if self.entity.isHolding then
        if self.entity.holding == SWORD then

            if p1_input:pressed('attack') then
                self.entity:changeState('attack')
            end
        end
    end

end