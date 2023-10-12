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
            text = '(ESC) Resume',
            key = 'escape',
            action = function() gStateStack:pop() end
        },
        {
            text = 'Back',
            key = 'attack',
            action = function() gStateStack:pop() end
        },
    }

    self.menu = Menu {
        canSelect = true,
        items = items,
        buttons = self.buttons
    }

    self.canSelect = false

end

function PauseState:enter()
    game_paused = true

    Timer.after(30 * delta_time, function() self.canSelect = true end)
end

function PauseState:update(dt)
    self.menu:update()

    if p1_input:pressed('start') then
        gStateStack:pop()
    end

    -- This is to avoid escaping or detecting a key too fast
    if not self.canSelect then return end

    -- Deal with buttons here
    for i = 1, #self.buttons do
        if p1_input:pressed(self.buttons[i].key) then
            self.buttons[i].action()
        end
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