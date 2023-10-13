BaseSettingsState = Class{__includes = BaseState}

function BaseSettingsState:update(dt)
    self.menu:update()
end

function BaseSettingsState:render()
    self.menu:render()
end

function BaseSettingsState:setMenu(items)
    self.menu = Menu {
        items = items
    }
end