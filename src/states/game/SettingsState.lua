SettingsState = Class{__includes = BaseState}

function SettingsState:init()
    local items = {
        {
            text = 'Controls',
            onSelect = function() gStateStack:push(ControlsSettingsState()) end
        },
        {
            text = 'Back',
            onSelect = function() gStateStack:pop() end
        }
    }
    
    self.buttons = {
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
            action = function() gStateStack:pop(2) end
        },
    }

    self.menu = Menu {
        canSelect = true,
        items = items,
        buttons = self.buttons
    }

end

function SettingsState:update(dt)
    self.menu:update()

    -- Deal with buttons here
    for i = 1, #self.buttons do
        if p1_input:pressed(self.buttons[i].key) then
            self.buttons[i].action()
        end
    end
end

function SettingsState:render()
    self.menu:render()
end