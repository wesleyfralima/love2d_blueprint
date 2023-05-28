PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity)
    EntityWalkState.init(self, entity)
end

function PlayerWalkState:update(dt)
    if p1_input:down('right') or p1_input:down('left') then

        local x, _ = p1_input:get('move')

        if x < 0 then
            if self.entity.direction == 'right' then
                self.entity:changeDirection('left')
            end

            self.entity.x = self.entity.x + math.floor(x*self.moveSpeed*dt)

        elseif x > 0 then
            if self.entity.direction == 'left' then
                self.entity:changeDirection('right')
            end

            self.entity.x = self.entity.x + math.ceil(x*self.moveSpeed*dt)
        end
    else
        self.entity:changeState('idle')
    end
end