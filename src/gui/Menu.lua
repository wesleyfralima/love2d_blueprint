Menu = Class{}

function Menu:init(def)
    local width = def.width or MENU_WIDTH
    local height = def.height or MENU_HEIGHT

    local x = def.x or VIRTUAL_WIDTH / 2 - width / 2
    local y = def.y or VIRTUAL_HEIGHT / 2 - height / 2

    self.panel = Panel(x, y, width, height)
    
    self.selection = Selection {
        items = def.items,
        buttons = def.buttons,
        x = x,
        y = y,
        width = width,
        height = height,
        font = def.font,
        canSelect = def.canSelect
    }
end

function Menu:update(dt)
    self.selection:update(dt)
end

function Menu:render()
    self.panel:render()
    self.selection:render()
end