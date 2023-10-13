StateStack = Class{}

function StateStack:init()
    self.states = {}
end

function StateStack:update(dt)
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