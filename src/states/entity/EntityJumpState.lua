EntityJumpState = Class{__includes = EntityBaseState}

function EntityJumpState:enter(entity)
    self.entity:changeAnimation('jump-' .. self.entity.direction)
end