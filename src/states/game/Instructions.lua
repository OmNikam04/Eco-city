Instructions = Class {
    __includes = BaseState
}

function Instructions:init()
    self.background = love.graphics.newImage('assets/images/inst.jpg') -- Load your background image

    -- Load a custom font with larger size
    self.titleFont = love.graphics.newFont('assets/fonts/EncodeSansSemiCondensed-Black.ttf', 32)
    self.font = love.graphics.newFont('assets/fonts/VT323-Regular.ttf', 24)
end

function Instructions:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(MainMenu())
    end
end

function Instructions:render()
    local screenWidth, screenHeight = love.graphics.getDimensions() -- Get screen dimensions

    -- Draw the background image to fill the entire screen
    love.graphics.draw(self.background, 0, 0, 0, screenWidth / self.background:getWidth(), screenHeight / self.background:getHeight())

    -- Title with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(self.titleFont)
    love.graphics.print("Instructions", 300, 50)

    -- Instruction 1 with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(self.font)
    love.graphics.print("Welcome to the city!", 50, 100)

    -- Instruction 2 with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Your mission is to find and fix renewable energy resources like solar panels and windmills.", 50, 150)

    -- Instruction 3 with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Use the arrow keys (up, down, left, right) to move around.", 50, 200)

    -- Additional Instructions with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Additional Instructions:", 50, 250)

    -- Instruction 4 with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("1. Search for renewable energy resources like solar panels and windmills in the city.", 50, 300)

    -- Instruction 5 with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("2. Interact with these resources to repair and activate them.", 50, 350)

    -- Instruction 6 with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("3. Keep an eye on your energy level to complete the mission successfully.", 50, 400)

    -- Press Enter to Continue with larger size
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Press Enter to Continue to the Main Menu", 200, 500)
end
