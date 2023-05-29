Player = Class{__includes = Entity}

function Player:processMovement(inputX, inputY)
    if inputX > 0 then 
        self.direction = 'right'
        inputX = math.ceil(inputX)
        self.x = self.x + math.ceil(inputX * self.dx * delta_time)

    elseif inputX < 0 then 
        self.direction = 'left' 
        inputX = math.floor(inputX)
        self.x = self.x + math.floor(inputX * self.dx * delta_time)
    end
end