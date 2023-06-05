Hitbox = Class{}

function Hitbox:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Hitbox:collided(target)
    return not (
        self.x + self.width     < target.x or 
        self.y + self.height    < target.y or 
        self.x                  > target.x + target.width or
        self.y                  > target.y + target.height
    )
end

function Hitbox:render()
    love.graphics.setColor(gColors['ImperialRed'])
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(gColors['White'])
end