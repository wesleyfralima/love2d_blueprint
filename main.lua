require 'src/Dependencies'

function love.load()
    -- Give a title for the window. More info at https://love2d.org/wiki/love.window.setTitle
    love.window.setTitle('Untitled Game')
    -- Set the filter for the game (for pixel art). More info at https://love2d.org/wiki/FilterMode
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- Setting a seed for randomness
    math.randomseed(os.time())

    -- Setting the screen resolution ann rendering using push library
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    -- Setting the StateStack. Definition found at src/states/StateStack.lua
    gStateStack = StateStack()
    -- Pushing the first state of the game into the StateStack (can also be StartState or any other)
    gStateStack:push(PlayState()) -- must be changed later

    game_paused = false
    delta_time = 0
    gFullscreen = false
end

-- Using push to resize the game when the screen is resized
function love.resize(w, h)
    push:resize(w, h)
end

-- Love function that keeps track of pressed keys in last frame
function love.keypressed(key)
    if key == 'escape' then
        if not game_paused then
            gStateStack:push(PauseState())
        end
    end

    if key == 'f' then
        love.window.setFullscreen( gFullscreen )
        gFullscreen = not gFullscreen
    end
end

-- Normal love.update, which is executed once per frame
function love.update(dt)
    -- Sometimes it is useful to use dt outside an update function
    delta_time = dt

    -- Updating the Timer variable. This is defined at Dependencies.lua
    Timer.update(dt)
    -- Updating the StateStack
    gStateStack:update(dt)
    -- Update input from baton
    p1_input:update()
end

function love.draw()
    -- push is once again used to draw, instead of drawing everything alone
    push:start()
        -- draw from the StateStack
        gStateStack:render()

        -- draw FPS
        love.graphics.draw(formatFPS(), 10, 10)

    push:finish()
end