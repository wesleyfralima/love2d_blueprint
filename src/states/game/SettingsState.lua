SettingsState = Class{__includes = BaseSettingsState}

function SettingsState:init()
    local items = {
        {
            text = 'Controls',
            onSelect = function() gStateStack:push(ControlsSettingsState()) end
        },
        {
            text = 'Audio',
            onSelect = function() return end
        }
    }

    self:setMenu(items)

end
