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

    local width = VIRTUAL_WIDTH - 20
    local height = VIRTUAL_HEIGHT - 20
    local x = VIRTUAL_WIDTH / 2 - width / 2
    local y = VIRTUAL_HEIGHT / 2 - height / 2

    self.menu = Menu {
        centered = false,
        canSelect = true,
        width = width,
        height = height,
        x = x,
        y = y,
        items = items
    }

end

function SettingsState:enter()
    
end

function SettingsState:update(dt)
    self.menu:update()

    if p1_input:pressed('escape') then
        gStateStack:pop()
    end
end

function SettingsState:render()
    self.menu:render()
end