PlayerBaseState = Class{__includes = EntityBaseState}

function PlayerBaseState:update(dt)
    -- Gets the current velocity from the player
    self.vx, self.vy = self.entity.collider:getLinearVelocity()

    -- Checks if player is on ground
    if self.entity.collider:enter('Ground') then
        self.entity.isOnGround = true
    elseif self.entity.collider:exit('Ground') then
        self.entity.isOnGround = false
    end

    -- If player walks from an edge, he must fall
    -- Same if he was pushed by anything (wind, enemy)
    if (self.name == 'idle' or self.name == 'walk') and not self.entity.isOnGround then
        self.entity:changeState('fall')
    end

    -- If player is in hurt state, limit his behaviour
    if not self.entity.isHurting then
        
        -- Handle movement and right direction
        self.inputX, self.inputY = p1_input:get('move')
        self.entity:processXMovement(self.inputX)
        self:assertRightXAndDirection(self.inputX)
    
        -- If jump was pressed and player is on ground, perform a jump
        if p1_input:pressed('jump') then
            if self.entity.isOnGround then
                self.entity.collider:applyLinearImpulse( 0, self.entity.dy )
                self.entity:changeState('jump')
            end
        end

        -- Following code is meant to be executed if player is
        -- holding any item or weapon. If not, return here
        if not self.entity.isHolding then return end

        -- If player is not already attacking, attack
        if p1_input:pressed('attack') then
            if self.name ~= 'attack' then
                self.entity:changeState('attack')
            end
        end
    end

end