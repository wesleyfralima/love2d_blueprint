Menu = Class{}

function Menu:init(def)
    local width = def.width or MENU_WIDTH
    local height = def.height or MENU_HEIGHT

    local x = def.x or VIRTUAL_WIDTH / 2 - width / 2
    local y = def.y or VIRTUAL_HEIGHT / 2 - height / 2

    self.buttons = def.buttons or {
        {
            text = '[Enter] Select',
            key = 'interact',
            action = function() return end
        },
        {
            text = '[backspace] Back',
            key = 'back',
            action = function() gStateStack:pop() end
        },
        {
            text = '[ESC] Resume',
            key = 'escape',
            action = function() gStateStack:pop() end
        },
    }
    
    self.panel = Panel(x, y, width, height)
    
    self.selection = Selection {
        items = def.items,
        buttons = self.buttons,
        x = x,
        y = y,
        width = width,
        height = height,
        font = def.font
    }

    Timer.after(30 * delta_time, function() self.canSelect = true end)
end

function Menu:update(dt)
    self.selection:update(dt)

    -- This is to avoid escaping or detecting a key too fast
    if not self.canSelect then return end

    -- Deal with buttons here
    for i = 1, #self.buttons do
        if p1_input:pressed(self.buttons[i].key) then
            self.buttons[i].action()
        end
    end
end

function Menu:render()
    self.panel:render()
    self.selection:render()
end