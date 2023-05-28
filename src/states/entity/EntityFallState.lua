EntityFallState = Class{__includes = EntityBaseState}

function EntityFallState:enter(entity)
    self.entity:changeAnimation('fall-' .. self.entity.direction)
end