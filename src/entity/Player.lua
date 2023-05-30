Player = Class{__includes = Entity}

function Player:processMovement(inputX, inputY)
    if inputX > 0 then 
        self.x = self.x + math.ceil(inputX * self.dx * delta_time)
        inputX = math.ceil(inputX)
    elseif inputX < 0 then 
        self.x = self.x + math.floor(inputX * self.dx * delta_time)
        inputX = math.floor(inputX)
    end

    return inputX, inputY
end