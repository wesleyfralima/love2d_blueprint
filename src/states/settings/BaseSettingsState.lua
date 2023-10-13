BaseSettingsState = Class{__includes = BaseState}

function BaseSettingsState:update(dt)
    self.menu:update()
end

function BaseSettingsState:render()
    self.menu:render()
end
