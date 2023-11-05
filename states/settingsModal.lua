local settingsModal = {}
local modalText = ""
local showModal = false
local closeButtonActive = false
local modalWidth = 700
local modalHeight = 450
local modalX = 600
local modalY = 250
local cornerRadius = 10
local closeButtonX = modalX + modalWidth - 40
local closeButtonY = modalY + 10
local closeButtonWidth = 30
local closeButtonHeight = 30
local soundOn = true
local volume = 50
local soundButtonWidth = 120
local soundButtonHeight = 40
local buttonCornerRadius = 5
local soundButtonX = modalX + (modalWidth - soundButtonWidth) / 2
local soundButtonY = modalY + 120

function settingsModal.showSettings()
    modalText = ""
    showModal = true
    closeButtonActive = true
end

function settingsModal.draw()
    if showModal then
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", modalX, modalY, modalWidth, modalHeight, cornerRadius, cornerRadius)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont("assets/fonts/EncodeSansSemiCondensed-Black.ttf", 18))
        local headingText = "Settings"
        local textWidth = love.graphics.getFont():getWidth(headingText)
        local textX = modalX + (modalWidth - textWidth) / 2
        local textY = modalY + 20
        love.graphics.print(headingText, textX, textY)

        local isOverSoundButton = love.mouse.getX() >= soundButtonX and love.mouse.getX() <= soundButtonX + soundButtonWidth
            and love.mouse.getY() >= soundButtonY and love.mouse.getY() <= soundButtonY + soundButtonHeight

        if isOverSoundButton then
            love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
        else
            love.mouse.setCursor()
        end

        love.graphics.setColor(0, 255, 0)
        if not soundOn then
            love.graphics.setColor(255, 0, 0)
        end
        love.graphics.rectangle("fill", soundButtonX, soundButtonY, soundButtonWidth, soundButtonHeight, buttonCornerRadius, buttonCornerRadius)

        local buttonText = soundOn and "Sound On" or "Sound Off"
        love.graphics.setColor(255, 255, 255)
        love.graphics.setFont(love.graphics.newFont("assets/fonts/EncodeSansSemiCondensed-Black.ttf", 18))
        local buttonTextWidth = love.graphics.getFont():getWidth(buttonText)
        local buttonTextX = soundButtonX + (soundButtonWidth - buttonTextWidth) / 2
        local buttonTextY = soundButtonY + (soundButtonHeight - love.graphics.getFont():getHeight()) / 2
        love.graphics.print(buttonText, buttonTextX, buttonTextY)

        if isOverSoundButton and love.mouse.isDown(1) then
            soundOn = not soundOn
        end

        local isOverCloseButton = love.mouse.getX() >= closeButtonX and love.mouse.getX() <= closeButtonX + closeButtonWidth
            and love.mouse.getY() >= closeButtonY and love.mouse.getY() <= closeButtonY + closeButtonHeight

        if isOverCloseButton then
            love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
        else
            love.mouse.setCursor()
        end

        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", closeButtonX, closeButtonY, closeButtonWidth, closeButtonHeight, buttonCornerRadius, buttonCornerRadius)

        love.graphics.setColor(255, 255, 255)
        love.graphics.line(closeButtonX + 5, closeButtonY + 5, closeButtonX + closeButtonWidth - 5, closeButtonY + closeButtonHeight - 5)
        love.graphics.line(closeButtonX + 5, closeButtonY + closeButtonHeight - 5, closeButtonX + closeButtonWidth - 5, closeButtonY + 5)

        if isOverCloseButton and love.mouse.isDown(1) then
            showModal = false
        end
    end
end

return settingsModal
