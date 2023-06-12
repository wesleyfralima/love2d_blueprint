Bar = Class{}

function Bar:init(def)
    self.size = 62

    self.image = def.image
    self.imageX = def.x
    self.imageY = def.y

    self.bar = gTextures['HUD']['bar']
    self.barX = self.imageX + self.image:getWidth() - 2
    self.barY = self.imageY + math.floor(self.image:getHeight() / 2) - self.bar:getHeight()/2

    self.fillColor = def.fillColor
    self.fillX = self.barX
    self.fillY = self.barY + 3
    self.completion = def.player.health / def.player.maxHealth
end

function Bar:render()
    -- Draw container
    love.graphics.draw(self.bar, self.barX, self.barY)

    -- Draw fill
    love.graphics.setColor(self.fillColor)
    love.graphics.rectangle('fill', self.fillX, self.fillY, self.size * self.completion, 2)
    love.graphics.setColor(gColors['White'])

    -- Draw image
    love.graphics.draw(self.image, self.imageX, self.imageY)
end

function Bar:setCompletion(completion)
    self.completion = completion
end