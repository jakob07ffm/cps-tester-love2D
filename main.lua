function love.load()
    target = {}
    target.x = 0
    target.y = love.graphics.getHeight() / 2
    target.width = love.graphics.getWidth()
    target.height = love.graphics.getHeight() / 2

    score = 0
    timer = 5

    gameFont = love.graphics.newFont(40)

    mouse = {}

    cpm = 0
end

function love.update(dt) 
    mouse.x, mouse.y = love.mouse.getPosition()
    
    timer = timer - dt

    
end

function love.draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", target.x, target.y, target.width, target.height)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print(score, 0, 0)

    if timer >= 0 then
        love.graphics.print(math.floor(timer), 40, 0)
    else 
        love.graphics.print("CPM:")
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and timer >= 0 then
        if isMouseInRect(mouse.x, mouse.y, target) then
            score = score + 1
        end
    end
end

function isMouseInRect(x, y, target)
    return x >= target.x and x <= (target.x + target.width) and
           y >= target.y and y <= (target.y + target.height)
end
