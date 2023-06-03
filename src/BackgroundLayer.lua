BackgroundLayer = Class{}

function BackgroundLayer:init(def)
    self.image = def.image

    self.width = gTextures[self.image]:getWidth()
    -- self.height = gTextures[self.image]:getHeight()

    self.xSpeed = def.xSpeed
    -- self.ySpeed = def.ySpeed

    self.y = def.y

    self.offsetX = 0
    self.offsetY = self.y
end

function BackgroundLayer:update(dt)

    local dx, _ = p1_input:get('move')
    
    if dx > 0 then
        self.offsetX = (self.offsetX + self.xSpeed * dt) % self.width
    elseif dx < 0 then
        self.offsetX = (self.offsetX - self.xSpeed * dt) % self.width
    end
end

function BackgroundLayer:render()
    love.graphics.draw(gTextures[self.image], self.x - self.width - self.offsetX, self.offsetY)
    love.graphics.draw(gTextures[self.image], self.x              - self.offsetX, self.offsetY)
    love.graphics.draw(gTextures[self.image], self.x + self.width - self.offsetX, self.offsetY)
end

function BackgroundLayer:setPosition(x, y)
    self.x = x
    self.y = y
end