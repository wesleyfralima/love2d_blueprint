require 'src/Dependencies'

function love.load()
    -- Give a title for the window. More info at https://love2d.org/wiki/love.window.setTitle
    love.window.setTitle('Untitled Game')
    -- Set the filter for the game (pixel art). More info at https://love2d.org/wiki/FilterMode
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
    gStateStack:push(StartState()) -- must be changed later
end

-- Using push to resize the game when the screen is resized
function love.resize(w, h)
    push:resize(w, h)
end

-- Love function that keeps track of pressed keys in last frame
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit() -- or the pause menu or the confirmation-to-exit state
    end
end

-- Normal love.update, which is executed once per frame
function love.update(dt)
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
        -- Here the only thing that needs to be drawn is from the StateStack
        gStateStack:render()

        love.graphics.setFont(gFonts.small)
        love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    push:finish()
end