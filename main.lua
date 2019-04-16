function love.load()

end

function love.update(dt)

end

function love.draw()
    drawFingerboard(10, 10, 675, 60, 90)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function drawFingerboard(x, y, length, headWidth, bodyWidth)
    love.graphics.setBackgroundColor(0.7, 0.7, 0.5)
    local position1, position2, position3, position4 = 3.5 / 22.5, 7 / 22.5, 9 / 22.5, 12 / 22.5
    local height1, height2, height3, height4 = 
        ((bodyWidth - headWidth) / 2) * (1 - position1),
        ((bodyWidth - headWidth) / 2) * (1 - position2),
        ((bodyWidth - headWidth) / 2) * (1 - position3),
        ((bodyWidth - headWidth) / 2) * (1 - position4),
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.setLineWidth(2)
    love.graphics.polygon('line', x, y + (bodyWidth - headWidth) /  2, x + length, y, x + length, y + bodyWidth, x, y + headWidth + (bodyWidth - headWidth) / 2)
    love.graphics.polygon('fill', x, y + (bodyWidth - headWidth) /  2, x + length, y, x + length, y + bodyWidth, x, y + headWidth + (bodyWidth - headWidth) / 2)
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.line(x + position1 * length, y + height1, x + position1 * length, y + bodyWidth - height1)
    love.graphics.line(x + position2 * length, y + height2, x + position2 * length, y + bodyWidth - height2)
    love.graphics.line(x + position3 * length, y + height3, x + position3 * length, y + bodyWidth - height3)
    love.graphics.line(x + position4 * length, y + height4, x + position4 * length, y + bodyWidth - height4)

    love.graphics.setColor(0.75, 0.75, 0.75)
    love.graphics.circle('fill', x + position1 * length, y + (bodyWidth * 1) / 5, 5)
    love.graphics.circle('fill', x + position1 * length, y + (bodyWidth * 2) / 5, 5)
    love.graphics.circle('fill', x + position1 * length, y + (bodyWidth * 3) / 5, 5)
    love.graphics.circle('fill', x + position1 * length, y + (bodyWidth * 4) / 5, 5)

    love.graphics.circle('fill', x + position2 * length, y + (bodyWidth * 1) / 5, 5)
    love.graphics.circle('fill', x + position2 * length, y + (bodyWidth * 2) / 5, 5)
    love.graphics.circle('fill', x + position2 * length, y + (bodyWidth * 3) / 5, 5)
    love.graphics.circle('fill', x + position2 * length, y + (bodyWidth * 4) / 5, 5)

    love.graphics.circle('fill', x + position3 * length, y + (bodyWidth * 1) / 5, 5)
    love.graphics.circle('fill', x + position3 * length, y + (bodyWidth * 2) / 5, 5)
    love.graphics.circle('fill', x + position3 * length, y + (bodyWidth * 3) / 5, 5)
    love.graphics.circle('fill', x + position3 * length, y + (bodyWidth * 4) / 5, 5)

    love.graphics.circle('fill', x + position4 * length, y + (bodyWidth * 1) / 5, 5)
    love.graphics.circle('fill', x + position4 * length, y + (bodyWidth * 2) / 5, 5)
    love.graphics.circle('fill', x + position4 * length, y + (bodyWidth * 3) / 5, 5)
    love.graphics.circle('fill', x + position4 * length, y + (bodyWidth * 4) / 5, 5)
end