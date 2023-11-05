Credit = Class {
    __includes = BaseState
}

local developers = {
    { name = "Aditya Mittal", role = "Lead Developer", game = "Windmill Revival" },
    { name = "Mayuri Kolhe", role = "2D Assets and Map Creator", game = "World Design" },
    { name = "Pranay Chauvan", role = "Menu and Soundtrack Developer", game = "Solar Panel Challenge" },
    { name = "Om Nikam", role = "Handled Player-World dynamics", game = "River Restoration Challenge" },
}

-- Background image
local background = love.graphics.newImage("assets/images/cn.jpg")

function Credit:init()
    self.tfont = love.graphics.newFont("assets/fonts/EncodeSansSemiCondensed-Black.ttf", 36)
    self.titleFont = love.graphics.newFont("assets/fonts/EncodeSansSemiCondensed-Black.ttf", 24)  -- Adjust the title font size as needed
    self.textFont = love.graphics.newFont("assets/fonts/VT323-Regular.ttf", 25)  -- Adjust the text font size as needed
    for _, body in pairs(world:getBodies()) do
        body:destroy()
    end
end

function Credit:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(MainMenu())
    end
end

function Credit:render()
    -- Draw the background image
    love.graphics.draw(background, 0, 0, 0, VIRTUAL_WIDTH / background:getWidth(), VIRTUAL_HEIGHT / background:getHeight())

    -- Calculate the position for the "Credits" title to center it on the screen
    local title = "Congratulations!!!!!!!"
    local titleWidth = self.titleFont:getWidth(title)
    local titleX = (VIRTUAL_WIDTH - titleWidth) / 2
    local titleY = 150  -- Adjust the vertical position as needed
    
    love.graphics.setFont(self.tfont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(title, titleX, titleY)
    
    local columnWidth = 350  -- Increase the width to add more space between columns
    local rowHeight = 150  -- Adjust the height as needed
    local xSpacing = 50  -- Increase the horizontal spacing
    
    local x = 100
    local y = titleY + self.tfont:getHeight() + 40  -- Adjust the starting Y position as needed
    
    for i, developer in ipairs(developers) do
        if (i - 1) % 2 == 0 and i > 1 then
            x = 100
            y = y + rowHeight + 20  -- Add more vertical spacing
        end

        love.graphics.setFont(self.titleFont)
        love.graphics.print(developer.name, x, y)
        
        love.graphics.setFont(self.textFont)
        love.graphics.print(developer.role, x, y + self.titleFont:getHeight())
        love.graphics.print(developer.game, x, y + self.titleFont:getHeight() + self.textFont:getHeight() + 5)  -- Adjust the vertical spacing as needed
        
        x = x + columnWidth + xSpacing  -- Increase the horizontal spacing
    end
    
    -- Calculate the position for the message text and display it below the credits
    local messageText = "In Greenvale, we play with wind, sun, and water, harnessing their power for a cleaner, greener future. Windmills, solar panels, and a free-flowing river symbolize our journey toward sustainable energy. Each spin, each glint, and the river's flow tell the story of a greener tomorrow."
    
    love.graphics.setFont(self.textFont, 30)  -- Use the text font for the message
    love.graphics.printf(messageText, 100, y + rowHeight + 80, VIRTUAL_WIDTH - 200, "left")
end