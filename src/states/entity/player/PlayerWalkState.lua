PlayerWalkState = Class{__includes = EntityBaseState}

function PlayerWalkState:update(dt)
    
    local x, _ = p1_input:get('move')

    if x == 0 then 
        self.entity:changeState('idle')
    end

    if p1_input:pressed('jump') then
        self.entity.collider:applyLinearImpulse( 0, self.entity.dy )
        self.entity:changeState('jump')
    end

    self.entity:processXMovement(x)
    self:assertRightXAndDirection(x)

    if self.entity.isHolding then
        if self.entity.holding == SWORD then

            if self.entity.direction == LEFT then
                self.entity.colliderOffsetX = -13
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