Selection = Class{}

function Selection:init(def)
    self.canSelect = def.canSelect

    self.items = def.items
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = def.font or gFonts['medium']

    self.gapHeight = self.height / #self.items

    self.currentSelection = 1
end

function Selection:update(dt)
    if self.canSelect then
        if p1_input:pressed('up') then
            if self.currentSelection == 1 then
                self.currentSelection = #self.items
            else
                self.currentSelection = self.currentSelection - 1
            end
            
        elseif p1_input:pressed('down') then
            if self.currentSelection == #self.items then
                self.currentSelection = 1
            else
                self.currentSelection = self.currentSelection + 1
            end
            
        elseif p1_input:pressed('interact') then
            self.items[self.currentSelection].onSelect()
        end
    end
end

function Selection:render()
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = math.ceil(currentY + (self.gapHeight / 2) - self.font:getHeight() / 2)

        -- draw selection marker if we're at the right index
        if self.canSelect then
            if i == self.currentSelection then
                love.graphics.draw(gTextures['cursor'], self.x - 8, paddedY)
            end
        end

        love.graphics.setFont(self.font)
        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')

        currentY = currentY + self.gapHeight
    end
end