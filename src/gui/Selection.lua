Selection = Class{}

function Selection:init(def)
    self.canSelect = def.canSelect or true

    self.items = def.items
    self.buttons = def.buttons or {}

    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width

    self.font = def.font or gFonts['medium']
    self.buttonsFont = gFonts['medium']

    if #self.buttons > 0 then
        self.space = self.height * 0.2
    else
        self.space = 0
    end

    self.gapHeight = math.ceil(1.3 * self.font:getHeight())
    self.gapWidth = math.ceil(self.width / #self.buttons)

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
    local currentY = self.y + (self.height - self.space - #self.items*self.gapHeight) / 2

    for i = 1, #self.items do
        local paddedY = math.ceil(currentY + (self.gapHeight / 2) - self.font:getHeight() / 2)

        -- draw selection marker if we're at the right index
        if self.canSelect then
            if i == self.currentSelection then
                love.graphics.draw(gTextures['cursor'], self.x + 115, paddedY)
            end
        end

        love.graphics.setFont(self.font)
        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')

        currentY = currentY + self.gapHeight
    end

    -- render the following if there is any button in the selection
    if self.space ~= 0 then
        local currentX = self.x
        local currentY = math.ceil(self.y + self.height - (self.space + self.buttonsFont:getHeight()) / 2)

        -- render buttons here
        for i = 1, #self.buttons do
            love.graphics.printf(self.buttons[i].text, currentX, currentY, self.gapWidth, 'center')
            currentX = currentX + self.gapWidth
        end

        -- draw horizontal line
        love.graphics.setColor(gColors['Zomp'])
        love.graphics.rectangle('fill', self.x + 10, self.y + self.height - self.space, self.width - 20, 2)
    end
end