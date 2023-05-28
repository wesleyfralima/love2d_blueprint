PauseState = Class{__includes = BaseState}

function PauseState:init()
    local width = 100
    local height = 50
    local x = VIRTUAL_WIDTH / 2 - width / 2
    local y = VIRTUAL_HEIGHT / 2 - height / 2

    local items = {
        {
            text = 'Resume',
            onSelect = function() gStateStack:pop() end
        },
        {
            text = 'Quit Game',
            onSelect = function() love.event.quit() end
        }
    }

    self.menu = Menu {
        canSelect = true,
        width = width,
        height = height,
        x = x,
        y = y,
        items = items
    }

    self.canExit = false

end

function PauseState:enter()
    game_paused = true

    -- if canExit was always true, pressing escape to enter this state would also quit the game
    Timer.after(3 * delta_time, function() self.canExit = true end)
end

function PauseState:update(dt)
    self.menu:update()

    if p1_input:pressed('start') then
        gStateStack:pop()
    end

    if p1_input:pressed('escape') then
        if self.canExit then
            love.event.quit()
        end
    end
end

function PauseState:exit()
    game_paused = false
end

function PauseState:render()

    love.graphics.setColor(0, 0, 0, .9)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, 3)

    self.menu:render()
end