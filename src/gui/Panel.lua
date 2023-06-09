Panel = Class{}

function Panel:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.visible = true
end

function Panel:update(dt)

end

function Panel:render()
    if self.visible then
        -- rectangle on back
        love.graphics.setColor(gColors['Zomp'])
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 3)
        -- rectangle on front
        love.graphics.setColor(gColors['Cerulean'])
        love.graphics.rectangle('fill', self.x + 2, self.y + 2, self.width - 4, self.height - 4, 3)

        -- reseting color
        love.graphics.setColor(gColors['White'])
    end
end

function Panel:toggle()
    self.visible = not self.visible
end