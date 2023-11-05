local instructionsModal = {}
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
local modalFont = love.graphics.newFont("assets/fonts/EncodeSansSemiCondensed-SemiBold.ttf", 24)

function instructionsModal.showInstructions()
    modalText = "Welcome to EcoCraft Challenge!\n\n" ..
                "Instructions:\n" ..
                "- Use the arrow keys to move your character.\n" ..
                "- Collect all the green gems to complete the level.\n" ..
                "- Avoid the red enemies.\n" ..
                "- Press the 'S' key to open the settings.\n\n" ..
                "Good luck and have fun!"
    showModal = true
    closeButtonActive = true
end

function instructionsModal.draw()
    if showModal then
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", modalX, modalY, modalWidth, modalHeight, cornerRadius, cornerRadius)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(modalFont)
        local headingText = "Instructions"
        local textWidth = love.graphics.getFont():getWidth(headingText)
        local textX = modalX + (modalWidth - textWidth) / 2
        local textY = modalY + 20
        love.graphics.print(headingText, textX, textY)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(modalFont)
        textWidth = love.graphics.getFont():getWidth(modalText)
        textX = modalX + (modalWidth - textWidth) / 2
        textY = modalY + 60
        love.graphics.printf(modalText, textX, textY, modalWidth - 40, "left")

        local isOverCloseButton = love.mouse.getX() >= closeButtonX and love.mouse.getX() <= closeButtonX + closeButtonWidth
            and love.mouse.getY() >= closeButtonY and love.mouse.getY() <= closeButtonY + closeButtonHeight
        if isOverCloseButton then
            love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
            
        else
            love.mouse.setCursor()
            love.graphics.setColor(255, 0, 0)
        end

        love.graphics.rectangle("fill", closeButtonX, closeButtonY, closeButtonWidth, closeButtonHeight, 5, 5)
        love.graphics.setColor(255, 255, 255)
        love.graphics.line(closeButtonX + 5, closeButtonY + 5, closeButtonX + closeButtonWidth - 5, closeButtonY + closeButtonHeight - 5)
        love.graphics.line(closeButtonX + 5, closeButtonY + closeButtonHeight - 5, closeButtonX + closeButtonWidth - 5, closeButtonY + 5)
        if isOverCloseButton and love.mouse.isDown(1) then
            showModal = false
        end
    end
end


return instructionsModal
