local stringPositionNotes = {
    { 'E', 'F#', 'G#', 'A', 'B' },
    { 'A', 'B', 'C#', 'D', 'E' },
    { 'D', 'E', 'F#', 'G', 'A' },
    { 'G', 'A', 'B', 'C', 'D' }
}

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
    local numLines = 8
    for i = 1, numLines do
        if i > 2 and i < 8 then
            love.graphics.line(x, y + i * h / numLines - 0.5 * h / numLines, x + w, y + i * h / numLines - 0.5 * h / numLines)
        end
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
    
    local highlightedNote = ''
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
            end                
            love.graphics.circle('fill', pointX, pointY, radius)
            love.graphics.setColor(0, 0, 0)
            love.graphics.setLineWidth(1)
            love.graphics.circle('line', pointX, pointY, radius)
        end
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(highlightedNote, 20, 85)
end