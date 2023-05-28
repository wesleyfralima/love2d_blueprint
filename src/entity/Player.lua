Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)

    self.moveSpeed = 75
end

function Player:update(dt)
    Entity.update(self, dt)
end