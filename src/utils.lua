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