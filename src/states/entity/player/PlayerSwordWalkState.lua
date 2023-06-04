PlayerSwordWalkState = Class{__includes = EntityBaseState}

function PlayerSwordWalkState:enter()
    EntityBaseState.enter(self)

    if self.entity.direction == 'left' then
        self.entity.colliderOffsetX = -15
    else
        self.entity.colliderOffsetX = 0
    end
end

function PlayerSwordWalkState:update(dt)

    local x, _ = p1_input:get('move')
    self:assertRightXAndDirection(x)
    self.entity:processXMovement(x)

    if self.entity.direction == 'left' then
        self.entity.colliderOffsetX = -15
    else
        self.entity.colliderOffsetX = 0
    end

    if x == 0 then 
        self.entity:changeState('sword-idle')
    end

    if p1_input:pressed('jump') then
        self.entity.collider:applyLinearImpulse( 0, self.entity.dy )
        --self.entity:changeState('jump')
    end
    
end