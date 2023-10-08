ControlsSettingsState = Class{__includes = BaseState}

function ControlsSettingsState:init()
    local items = {
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

function ControlsSettingsState:enter()
    
end

function ControlsSettingsState:update(dt)
    self.menu:update()

    if p1_input:pressed('escape') then
        gStateStack:pop()
    end
end

function ControlsSettingsState:render()

    love.graphics.setColor(0, 0, 0, .9)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, 3)

    self.menu:render()
end