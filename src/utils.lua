function formatFPS()
    love.graphics.setColor(gColors['Zomp'])
    local fpsText = love.graphics.newText(gFonts.small, "Current FPS: " .. tostring(love.timer.getFPS()))

    return fpsText
end

function getTextSize(def)
    local text = def.text
    local textWidth = text:getWidth()
    local textHeight = text:getHeight()

    return textWidth, textHeight
end

function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end