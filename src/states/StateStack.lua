StateStack = Class{}

function StateStack:init()
    self.states = {}
end

function StateStack:update(dt)
    -- If there is no state, return
    -- This might be useful to always make PlayState be the first state, meaning
    -- there is a PlayState active if and only if it is at self.states[1]. So if we
    -- are at some StartState which is at self.states[1], we could easily pop that state and have no state 
    -- for a frame until PlayState is set.
    if #self.states < 1 then return end

    -- Update last state if there is any
    self.states[#self.states]:update(dt)
end

function StateStack:processAI(params, dt)
    self.states[#self.states]:processAI(params, dt)
end

function StateStack:render()
    for i, state in ipairs(self.states) do
        state:render()
    end
end

function StateStack:clear()
    self.states = {}
end

function StateStack:push(state)
    table.insert(self.states, state)
    state:enter()
end

function StateStack:pop(numberOfStates)
    local n = numberOfStates or 1
    local endState = #self.states - n + 1

    for i = #self.states, endState, -1 do
        self.states[i]:exit()
        table.remove(self.states, i)
    end
end

function StateStack:goToPlayState()
    -- This only works if PlayState is at self.states[1]
    self:pop(#self.states - 1)
end