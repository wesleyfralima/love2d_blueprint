EntityWalkState = Class{__includes = EntityBaseState}

function EntityWalkState:init(entity)
    EntityBaseState.init(self, entity)
end

function EntityWalkState:enter(entity)
    self.entity:changeAnimation('walk-' .. self.entity.direction)
end
