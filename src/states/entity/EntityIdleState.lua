EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:enter(entity)
    self.entity:changeAnimation('idle-' .. self.entity.direction)
end