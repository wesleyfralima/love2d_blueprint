Background = Class{}

function Background:init(def)
    self.layers = def.layers
    self:sort()
end

function Background:update(dt, x, y)
    for i, layer in pairs(self.layers) do
        layer:setPosition(x, y)
        layer:update(dt)
    end
end

function Background:render()
    for i, layer in pairs(self.layers) do
        layer:render()
    end
end

function Background:addLayer(backgroundLayer)
    table.insert(self.layers, backgroundLayer)
    self:sort()
end

function Background:sort()
    table.sort(self.layers, function(a, b) return a.xSpeed < b.xSpeed end)
end