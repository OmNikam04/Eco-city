-- Import required modules
local love = require("love")

local level1 = {}

function level1.draw()
    -- Draw the welcome message at the center of the screen
    local welcomeMessage = "Welcome to Level 1!"
    local textWidth = love.graphics.getFont():getWidth(welcomeMessage)
    local textX = (love.graphics.getWidth() - textWidth) / 2
    local textY = (love.graphics.getHeight() - love.graphics.getFont():getHeight()) / 2
    love.graphics.print(welcomeMessage, textX, textY)
end

return level1
