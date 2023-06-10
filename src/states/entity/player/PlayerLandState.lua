PlayerLandState = Class{__includes = EntityBaseState}

function PlayerLandState:update(dt)
    local x, y = p1_input:get('move')

    if self.entity.currentAnimation.status == 'paused' then
        self.entity:changeState('idle')
    end

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