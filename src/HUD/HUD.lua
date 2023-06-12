HUD = Class{}

function HUD:init(player)
    self.player = player

    self.fields = {
        ['health'] = Bar {
            image = gTextures['HUD']['heart'],
            x = 10,
            y = 30,
            fillColor = gColors['ImperialRed'],
            player = self.player,
        },
    }
end

function HUD:render()
    for _, field in pairs(self.fields) do
        field:render()
    end
end

function HUD:setCompletion(field, completion)
    self.fields[field]:setCompletion(completion)
end