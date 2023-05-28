PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.points = 0
    self.pointsPerAct = 1

    self.moveSpeed = 75

    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2
end

function PlayState:update(dt)
    if p1_input:pressed('start') then
        gStateStack:push(PauseState())
    end
    
    if p1_input:pressed('main_action') then
        self.points = self.points + self.pointsPerAct
    end

    if p1_input:pressed('side_action') then
        self.points = self.points - self.pointsPerAct
    end

    if p1_input:down('move') then
        local x, y = p1_input:get('move')

        if x < 0 then
            self.x = self.x + math.floor(x*self.moveSpeed*dt)
        elseif x > 0 then
            self.x = self.x + math.ceil(x*self.moveSpeed*dt)
        end

        if y < 0 then
            self.y = self.y + math.floor(y*self.moveSpeed*dt)
        elseif y > 0 then
            self.y = self.y + math.ceil(y*self.moveSpeed*dt)
        end

    end
end

function PlayState:render()
    love.graphics.setColor(gColors['Zomp'])
    love.graphics.setFont(gFonts.medium)
    love.graphics.print(self.points, self.x, self.y)
end