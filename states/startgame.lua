local love = require("love")
local settingsModal = require("states.settingsModal")
local instructionsModal = require("states.instructionsModal")
local level1 = require("levels.level1")
local startgame = {}
local background = love.graphics.newImage("assets/images/bg.jpg")
local buttonFont = love.graphics.newFont("assets/fonts/EncodeSansSemiCondensed-Black.ttf", 24)
local buttonWidth = 200
local buttonHeight = 60
local buttonSpacing = 20
local buttonX = 850
local startY = 400

local buttons = {
    { text = "Start Game", action = "start" },
    { text = "Exit Game", action = "exit" },
    { text = "Instructions", action = "instructions" },
    { text = "Settings", action = "settings" }
}
local cornerRadius = 10
local cursorChanged = false
local scaleFactor = 1.05
local scaleButton = nil
local showModal = false
local modalText = ""

function startgame.draw()
    love.graphics.setColor(100, 100, 100)
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), love.graphics.getHeight() / background:getHeight())

    cursorChanged = false

    for i, button in ipairs(buttons) do
        local buttonY = startY + (i - 1) * (buttonHeight + buttonSpacing)
        local mouseX, mouseY = love.mouse.getPosition()
        local isOverButton = mouseX >= buttonX and mouseX <= buttonX + buttonWidth and
            mouseY >= buttonY and mouseY <= buttonY + buttonHeight

        if isOverButton then
            if not scaleButton then
                scaleButton = button
            end

            love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
            love.graphics.setColor(255, 255, 255)
            love.graphics.rectangle("fill", buttonX - buttonWidth * (scaleFactor - 1) / 2, buttonY - buttonHeight * (scaleFactor - 1) / 2, buttonWidth * scaleFactor, buttonHeight * scaleFactor, cornerRadius, cornerRadius)
            love.graphics.setColor(0, 255, 0)
            love.graphics.rectangle("fill", buttonX, buttonY, buttonWidth, buttonHeight, cornerRadius, cornerRadius)
        else
            if scaleButton == button then
                scaleButton = nil
            end

            love.graphics.setColor(0, 255, 0)
            love.graphics.rectangle("fill", buttonX, buttonY, buttonWidth, buttonHeight, cornerRadius, cornerRadius)
        end

        local textWidth = buttonFont:getWidth(button.text)
        local textX = buttonX + (buttonWidth - textWidth) / 2
        local textY = buttonY + (buttonHeight - buttonFont:getHeight()) / 2
        love.graphics.setColor(255, 255, 255)
        love.graphics.setFont(buttonFont)
        love.graphics.print(button.text, textX, textY)

        if love.mouse.isDown(1) then
            if isOverButton then
                handleButtonClick(button.action)
            end
        end
    end

    if showModal then
        love.graphics.setColor(0, 0, 0, 200)
        love.graphics.rectangle("fill", 100, 100, love.graphics.getWidth() - 200, love.graphics.getHeight() - 200)
        love.graphics.setColor(255, 255, 255)
        love.graphics.setFont(buttonFont)
        love.graphics.printf(modalText, 120, 120, love.graphics.getWidth() - 240, "center")
    end

    if not cursorChanged then
        love.mouse.setCursor()
    end
end

function handleButtonClick(action)
    if action == "start" then
        switchScreen("level1")
    elseif action == "exit" then
        love.event.quit()
    elseif action == "instructions" then
        instructionsModal.showInstructions()
    elseif action == "settings" then
        settingsModal.showSettings()
    end
end

return startgame
