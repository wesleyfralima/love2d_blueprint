Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.texture = def.texture

    if def.looping == false then
        self.looping = false
    elseif def.looping == true then
        self.looping = true
    else
        self.looping = true
    end

    self.timer = 0
    self.currentFrame = 1

    -- used to see if we've seen a whole loop of the animation
    self.shouldStop = false
end

function Animation:exit()
    self:refresh()
end

function Animation:refresh()
    self.timer = 0
    self.currentFrame = 1
    self.shouldStop = false
end

function Animation:update(dt)
    -- no need to update if animation is only one frame
    if #self.frames == 1 then 
        return 
    end

    -- if we've reached the end, record
    if self.currentFrame == #self.frames then
        self.shouldStop = true

        -- if not self.looping then
        --     return
        -- end
    end

    -- if not a looping animation and we've played at least once, exit
    if not self.looping and self.shouldStop then
        return
    end

    self.timer = self.timer + dt

    if self.timer > self.interval then
        self.timer = self.timer % self.interval

        self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end

function Animation:goToFrame(frame)
    self.currentFrame = frame
end