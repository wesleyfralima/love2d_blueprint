BackgroundLayer = Class{}

function BackgroundLayer:init(def)
    self.image = def.image

    self.width = gTextures[self.image]:getWidth()
    -- self.height = gTextures[self.image]:getHeight()

    self.xSpeed = def.xSpeed
    -- self.ySpeed = def.ySpeed

    self.x = def.x
    self.y = def.y

    self.lastX = self.x
    self.lastY = self.y

    self.offsetX = 0
    self.offsetY = self.y
end

function BackgroundLayer:update(dt)
    if math.abs(self.x - self.lastX) <= 2 then 
        return 
    end
    
    local dx, _ = p1_input:get('move')
    
    if dx ~= 0 then
        self.offsetX = (self.offsetX + self.xSpeed * dt * dx) % self.width
        self.lastX, self.lastY = self.x, self.y
    end

end

function BackgroundLayer:render()
    love.graphics.draw(gTextures[self.image], round(self.x - self.width - self.offsetX), self.offsetY)
    love.graphics.draw(gTextures[self.image], round(self.x              - self.offsetX), self.offsetY)
    love.graphics.draw(gTextures[self.image], round(self.x + self.width - self.offsetX), self.offsetY)
end

function BackgroundLayer:setPosition(x, y)
    self.x = x
    self.y = y
end