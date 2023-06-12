Player = Class{__includes = Entity}

function Player:processXMovement(inputX)
    local vx = 0
    local _, vy = self.collider:getLinearVelocity()

    if inputX > 0 then 
        vx = math.ceil(inputX) * self.dx
    elseif inputX < 0 then 
        vx = math.floor(inputX) * self.dx
    end

    self.collider:setLinearVelocity(vx, vy)
end

function Player:rangeBox(range)
    local x, y = self.collider:getPosition()
    local height = 4

    if self.direction == RIGHT then
        x = x + 17
    else
        x = x - (17 + range)
    end

    return Hitbox(x, y, range, height)
end