PlayerJumpState = Class{__includes = EntityBaseState}

function PlayerJumpState:update(dt)
    local _, vy = self.entity.collider:getLinearVelocity()

    if vy >= 0 then
        self.entity:changeState('fall')
    elseif p1_input:released('jump') then
        self.entity.collider:setLinearVelocity( 0, 0.5 * self.entity.dy )
    end

    local x, y = p1_input:get('move')
    
    self.entity:processXMovement(x)
    self:assertRightXAndDirection(x)

    if self.entity.isHolding then
        if self.entity.holding == SWORD then

            if self.entity.direction == LEFT then
                self.entity.colliderOffsetX = -4
            else
                self.entity.colliderOffsetX = 0
            end

            if p1_input:pressed('attack') then
                print('sword slash')
            end
        end

    else
        self.entity.colliderOffsetX = 0
    end

end