function love.load()
    target = {}
    target.x = love.graphics.getWidth() / 4
    target.y = love.graphics.getHeight() / 2
    target.width = love.graphics.getWidth() / 2
    target.height = love.graphics.getHeight() / 2

    score = 0
    timer = 5

    gameFont = love.graphics.newFont(40)
    endFont = love.graphics.newFont(60)

    mouse = {}

    cps = 0
    gameStarted = false

    targetColor = {0.8, 0.2, 0.2}
    backgroundColor = {0.1, 0.1, 0.1} 
    textColor = {1, 1, 1}  
    borderColor = {1, 1, 0} 
end

function love.update(dt)
    mouse.x, mouse.y = love.mouse.getPosition()

    if gameStarted and timer > 0 then
        timer = timer - dt
        if timer <= 0 then
            timer = 0
            cps = score / 5  
        end
    end
end

function love.draw()
    love.graphics.setColor(backgroundColor)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(targetColor)
    love.graphics.rectangle("fill", target.x, target.y, target.width, target.height)
    
    love.graphics.setColor(borderColor)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", target.x, target.y, target.width, target.height)

    love.graphics.setColor(textColor)
    love.graphics.setFont(gameFont)
    love.graphics.print("Click: " .. score, 10, 10)
    love.graphics.print("Time: " .. math.floor(timer), 400, 10)

    if timer <= 0 and gameStarted then
        displayEnd()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if isMouseInRect(mouse.x, mouse.y, target) then
            if not gameStarted then
                gameStarted = true
            end
            if timer > 0 then
                score = score + 1
            end
        end
    end
end

function isMouseInRect(x, y, target)
    return x >= target.x and x <= (target.x + target.width) and
           y >= target.y and y <= (target.y + target.height)
end

function displayEnd()
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(textColor)
    love.graphics.setFont(endFont)
    local text = "CPS: " .. cps
    local textWidth = love.graphics.getFont():getWidth(text)
    local textHeight = love.graphics.getFont():getHeight()
    love.graphics.print(text, (love.graphics.getWidth() - textWidth) / 2, (love.graphics.getHeight() - textHeight) / 2)
end
