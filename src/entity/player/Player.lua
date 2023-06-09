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