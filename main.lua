local stringPositionNotes = {
    { '5E', '5F#', '5G#', '5A', '5B' },
    { '4A', '4B', '5C#', '5D', '5E' },
    { '4D', '4E', '4F#', '4G', '4A' },
    { '3G', '3A', '3B', '4C', '4D' }
}

local staffPositions = {
    ['3G'] = 9.5,
    ['3A'] = 9,
    ['3B'] = 8.5,
    ['4C'] = 8,

    ['4D'] = 7.5,
    ['4E'] = 7,
    ['4F#'] = 6.5,
    ['4G'] = 6,

    ['4A'] = 5.5,
    ['4B'] = 5,
    ['5C#'] = 4.5,
    ['5D'] = 4,
    
    ['5E'] = 3.5,
    ['5F#'] = 3,
    ['5G#'] = 2.5,
    ['5A'] = 2,
    ['5B'] = 1.5
}

local highlightedNote = nil

function love.load()

end

function love.update(dt)

end

function love.draw()
    drawFingerboard(50, 50, 675, 60, 90)
    drawStaff(50, 200, 200, 100)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function drawStaff(x, y, w, h)
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle('fill', x, y, w, h)

    love.graphics.setColor(0, 0, 0)
    local numLines = 10
    for i = 1, numLines do
        if i > 2 and i < 8 then
            love.graphics.setColor(0, 0, 0)
        else
            love.graphics.setColor(0, 0, 0, 0.25)
        end
        love.graphics.line(x, y + i * h / numLines - 0.5 * h / numLines, x + w, y + i * h / numLines - 0.5 * h / numLines)
    end
    love.graphics.setColor(0, 0, 0)
    if highlightedNote then
        love.graphics.circle('fill', x + 20, y + staffPositions[highlightedNote] * h / numLines - 0.5 * h / numLines, 5)
    end
end

function drawFingerboard(x, y, length, headWidth, bodyWidth)
    love.graphics.setBackgroundColor(0.7, 0.7, 0.5)
    local positions = { 0, 3.5 / 22.5, 7 / 22.5, 9 / 22.5, 12 / 22.5 }
    local heights = {}

    for i = 1, 5 do
        table.insert(heights, ((bodyWidth - headWidth) / 2) * (1 - positions[i]))
    end

    love.graphics.setColor(0.2, 0.2, 0.1)
    love.graphics.setLineWidth(2)
    love.graphics.polygon('line', x, y + (bodyWidth - headWidth) /  2, x + length, y, x + length, y + bodyWidth, x, y + headWidth + (bodyWidth - headWidth) / 2)
    love.graphics.polygon('fill', x, y + (bodyWidth - headWidth) /  2, x + length, y, x + length, y + bodyWidth, x, y + headWidth + (bodyWidth - headWidth) / 2)

    love.graphics.setColor(1, 1, 1)
    for i = 1, 5 do
        love.graphics.line(x + positions[i] * length, y + heights[i], x + positions[i] * length, y + bodyWidth - heights[i])
    end

    love.graphics.setColor(0.8, 0.8, 0.8)
    for i = 1, 4 do
        love.graphics.line(x, y + ((bodyWidth - headWidth) / 2) + headWidth * (i / 4) - headWidth / 8, x + length, y + bodyWidth * (i / 4) - bodyWidth / 8)
    end
    
    for i = 1, 5 do
        for j = 1, 4 do
            local pointX = x + positions[i] * length
            -- local pointY = y + (bodyWidth * j) / 4 - bodyWidth / 8
            local height = headWidth + (bodyWidth - headWidth) * positions[i]
            local offset = ((bodyWidth - headWidth) / 2) * (1 - positions[i])
            local pointY = y + (height * j / 4) + offset - height / 8
            local mouseX, mouseY = love.mouse.getPosition()
            local radius = 7.5
            if math.sqrt(math.pow(pointX - mouseX, 2) + math.pow(pointY - mouseY, 2)) < radius then
                love.graphics.setColor(1, 0, 0)
                highlightedNote = stringPositionNotes[j][i]
            else
                love.graphics.setColor(0.75, 0.75, 0.75)
                -- highlightedNote = nil
            end                
            love.graphics.circle('fill', pointX, pointY, radius)
            love.graphics.setColor(0, 0, 0)
            love.graphics.setLineWidth(1)
            love.graphics.circle('line', pointX, pointY, radius)
        end
    end

    love.graphics.setColor(0, 0, 0)
    if highlightedNote then
        love.graphics.print(highlightedNote:sub(2), 20, 85)
    end
end