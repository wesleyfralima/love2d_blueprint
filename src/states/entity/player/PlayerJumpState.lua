PlayerJumpState = Class{__includes = EntityJumpState}

function PlayerJumpState:enter()
    EntityJumpState.enter(self)
    self.entity.initialY = self.entity.y
end

function PlayerJumpState:update(dt)
    
    if self.entity.y < (self.entity.initialY - self.entity.jumpMaxHeight) then
        self.entity:changeState('fall')
    end

    self.entity.y = self.entity.y - (self.entity.dy * dt)

    local x, y = p1_input:get('move')

    if x ~= 0 then
        self.entity:processMovement(x, y)
    end

end