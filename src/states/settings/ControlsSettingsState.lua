ControlsSettingsState = Class{__includes = BaseSettingsState}

function ControlsSettingsState:init()
    local items = {
        {
            text = 'this is controls screen',
            onSelect = function() gStateStack:pop() end
        }
    }

    self:setMenu(items)
    
end
