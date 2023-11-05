--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MainMenu = Class {
    __includes = BaseState,
    bgMusic = love.audio.newSource("assets/sounds/bg.mp3", "stream")
}


function MainMenu:startBackgroundMusic()
    -- Set the volume for the background music (between 0 and 1)
    self.bgMusic:setVolume(0.5)

    -- Set the background music to loop
    self.bgMusic:setLooping(true)

    -- Start playing the background music
    love.audio.play(self.bgMusic)
end

function MainMenu:stopBackgroundMusic()
    -- Stop the background music
    love.audio.stop(self.bgMusic)
end

-- whether we're highlighting "Start" or "High Scores"
local highlighted = 1

-- Load the background image
local background = love.graphics.newImage("assets/images/bg.jpg")
-- Load the button click sound
local buttonClickSound = love.audio.newSource("assets/sounds/click-button.mp3", "static")

function MainMenu:init()
    counter_var = 1
    glevel = 1
    gtasks = 0
    fixedWindmill = false
    fixedHydro = false
    fixedSolar1 = false
    fixedSolar2 = false
    gcol1 = false
    gcol2 = false
    self:startBackgroundMusic()
end

function MainMenu:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') then
        if highlighted == 1 then
            highlighted = 5
        end
        highlighted = (highlighted - 1) % 5
    end

    if love.keyboard.wasPressed('down') then
        if highlighted == 4 then
            highlighted = 0
        end
        highlighted = (highlighted + 1) % 5
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        buttonClickSound:play() -- Play the button click sound

        if highlighted == 1 then
            gStateStack:pop()
            gStateStack:push(PlayState())
            gStateStack:push(DialogueState())
            
            -- Stop the background music when transitioning to the game
            self:stopBackgroundMusic()
        elseif highlighted == 2 then
            gStateStack:pop()
            gStateStack:push(Instructions())
            
            -- Stop the background music when transitioning to the game
            self:stopBackgroundMusic()
        elseif highlighted == 3 then
            gStateStack:pop()
            gStateStack:push(Credit())
            
            -- Stop the background music when transitioning to the game
            self:stopBackgroundMusic()
        elseif highlighted == 4 then
            gStateStack:pop()
            gStateStack:push(End())
            
            -- Stop the background music when transitioning to the game
            self:stopBackgroundMusic()
        end
    end
end

function MainMenu:render()
    -- Draw the background image
    love.graphics.draw(background, 0, 0, 0, VIRTUAL_WIDTH / background:getWidth(), VIRTUAL_HEIGHT / background:getHeight())

    -- Set the font for the title
    love.graphics.setFont(love.graphics.newFont("assets/fonts/EncodeSansSemiCondensed-Black.ttf", 50))
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Eco City", 0, VIRTUAL_HEIGHT / 2 + 50 - 250, VIRTUAL_WIDTH, 'center')

    -- Style for the buttons
    local buttonWidth = 250
    local buttonHeight = 60
    local buttonX = VIRTUAL_WIDTH / 2 - buttonWidth / 2
    local buttonY = VIRTUAL_HEIGHT / 2 - 50

    -- Check if the mouse cursor is over a button
    local mouseX, mouseY = love.mouse.getPosition()
    local isHovered = false

    -- Set the button color to green
    love.graphics.setColor(0, 1, 0) -- Green button background color

    -- Draw "START" button
    if highlighted == 1 then
        love.graphics.setColor(0, 0.8, 0) -- Highlighted color for selected button
    end
    love.graphics.rectangle('fill', buttonX, buttonY, buttonWidth, buttonHeight, 10, 10)

    -- Set the text color to white
    love.graphics.setColor(1, 1, 1) -- Text color
    love.graphics.setFont(love.graphics.newFont("assets/fonts/EncodeSansSemiCondensed-SemiBold.ttf", 30))
    love.graphics.printf("START", buttonX, buttonY + 15, buttonWidth, 'center')

    -- Draw "INSTRUCTIONS" button
    buttonY = buttonY + 100

    -- Reset the button color
    love.graphics.setColor(0, 1, 0) -- Green button background color

    if highlighted == 2 then
        love.graphics.setColor(0, 0.8, 0) -- Highlighted color for selected button
    end
    love.graphics.rectangle('fill', buttonX, buttonY, buttonWidth, buttonHeight, 10, 10)
    love.graphics.setColor(1, 1, 1) -- Text color
    love.graphics.printf("INSTRUCTIONS", buttonX, buttonY + 15, buttonWidth, 'center')

    -- Draw "CREDITS" button
    buttonY = buttonY + 100

    -- Reset the button color
    love.graphics.setColor(0, 1, 0) -- Green button background color

    if highlighted == 3 then
        love.graphics.setColor(0, 0.8, 0) -- Highlighted color for selected button
    end
    love.graphics.rectangle('fill', buttonX, buttonY, buttonWidth, buttonHeight, 10, 10)
    love.graphics.setColor(1, 1, 1) -- Text color
    love.graphics.printf("CREDITS", buttonX, buttonY + 15, buttonWidth, 'center')

    -- Draw "EXIT" button
    buttonY = buttonY + 100

    -- Reset the button color
    love.graphics.setColor(0, 1, 0) -- Green button background color

    if highlighted == 4 then
        love.graphics.setColor(0, 0.8, 0) -- Highlighted color for selected button
    end
    love.graphics.rectangle('fill', buttonX, buttonY, buttonWidth, buttonHeight, 10, 10)
    love.graphics.setColor(1, 1, 1) -- Text color
    love.graphics.printf("EXIT", buttonX, buttonY + 15, buttonWidth, 'center')

    -- If a button is hovered, play a hover sound
    if isHovered then
        -- Play your hover sound here
    end
end
