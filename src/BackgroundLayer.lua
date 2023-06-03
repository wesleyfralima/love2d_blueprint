BackgroundLayer = Class{}

function BackgroundLayer:init(def)
    self.image = def.image

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.xSpeed = def.xSpeed
    self.ySpeed = def.ySpeed

    self.y = def.y

    self.offsetX = 0
    self.offsetY = self.y
end

function BackgroundLayer:update(dt)

    local dx, _ = p1_input:get('move')
    
    if dx > 0 then
        self.offsetX = self.offsetX - self.xSpeed * dt
    elseif dx < 0 then
        self.offsetX = self.offsetX + self.xSpeed * dt
    end
    
    self.offsetX = self.offsetX % self.width
end

function BackgroundLayer:render()
    love.graphics.draw(self.image, self.offsetX, self.offsetY)
    love.graphics.draw(self.image, self.offsetX + self.width, self.offsetY)
    love.graphics.draw(self.image, self.offsetX - self.width, self.offsetY)
end