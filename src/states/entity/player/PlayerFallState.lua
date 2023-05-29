PlayerFallState = Class{__includes = EntityBaseState}

function PlayerFallState:enter()
    EntityBaseState.enter(self)
    self.entity.initialY = self.entity.y
end

function PlayerFallState:update(dt)

    -- this is so we can change direction in the air
    -- needs to be better approached
    -- self.entity:changeAnimation('fall-' .. self.entity.direction)
    
    if self.entity.y > (self.entity.initialY + self.entity.jumpMaxHeight) then
        self.entity:changeState('idle')
    end

    self.entity.y = self.entity.y + (self.entity.dy * dt)

    local x, _ = p1_input:get('move')

    if x > 0 then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + math.ceil(x * self.entity.dx * dt)

    elseif x < 0 then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x + math.floor(x * self.entity.dx * dt)
    end

end