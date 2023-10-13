PauseState = Class{__includes = BaseState}

function PauseState:init()
    local items = {
        {
            text = 'Settings',
            onSelect = function() gStateStack:push(SettingsState()) end
        },
        {
            text = 'Reset Game',
            onSelect = function() love.load() end
        },
        {
            text = 'Quit Game',
            onSelect = function() love.event.quit() end
        }
    }

    self.buttons = {
        {
            text = '[Enter] Select',
            key = 'interact',
            action = function() return end
        },
        {
            text = '[ESC] Resume',
            key = 'escape',
            action = function() gStateStack:pop(1) end
        },
    }

    self.menu = Menu {
        items = items,
        buttons = self.buttons
    }

end

function PauseState:enter()
    game_paused = true
end

function PauseState:update(dt)
    self.menu:update()

    if p1_input:pressed('start') then
        gStateStack:pop()
    end
end

function PauseState:exit()
    game_paused = false
end

function PauseState:render()

    love.graphics.setColor(0, 0, 0, .3)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    self.menu:render()
end