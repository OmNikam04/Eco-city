-- minigame.lua
local Minigame = {}

local objects = {} -- Table to store objects in the game
local categories = {"Solar-Powered", "Not Solar-Powered"} -- Categories for sorting
local timer = 30 -- Initial time limit
local score = 0 -- Player's score
local feedback = "" -- Feedback message
local solarPoweredImage, notSolarPoweredImage, background

-- Lists of solar and non-solar items
local solarItems = {
    love.graphics.newImage('/assets/images/solar/solar-ev.png'),
    love.graphics.newImage('/assets/images/solar/solar-2.png'), -- Add more solar items here
    love.graphics.newImage('/assets/images/solar/solar-grid.png'), -- Add more solar items here
    -- love.graphics.newImage('/assets/images/solar/solar-water-pump.webp') -- Add more solar items here
}

local nonSolarItems = {love.graphics.newImage('/assets/images/non-solar/co2.png') -- Add more non-solar items here
}

function Minigame.new()
    local self = setmetatable({}, {
        __index = Minigame
    })

    return self
end

function Minigame:load()
    -- Initialize the game state
    objects = {} -- Clear objects
    timer = 30
    score = 0
    feedback = ""

    -- Load background image
    background = love.graphics.newImage('/assets/images/bg.png')

    -- Load image assets for categories
    solarPoweredImage = love.graphics.newImage('/assets/images/solar/solar-energy.png')
    notSolarPoweredImage = love.graphics.newImage('/assets/images/non-solar/co2.png')

    -- loading the soundtracks
    sounds = {}
    sounds.bg = love.audio.newSource("/assets/sounds/minigame/bg.mp3", "stream")
    sounds.success = love.audio.newSource("/assets/sounds/minigame/short-success.mp3", "static")
    sounds.error = love.audio.newSource("/assets/sounds/minigame/negative_beeps.mp3", "static")

    sounds.bg:play()
end

local clickedThisFrame = false

function Minigame:update(dt)
    -- Update the game logic
    timer = timer - dt
    if timer <= 0 then
        -- End the game when the timer runs out
        feedback = "Time's up!"
        timer = 0
        return
    end

    -- Create new objects
    if #objects < 5 then
        local randomCategory = categories[love.math.random(1, 2)]
        local newObject = {
            x = love.math.random(50, love.graphics.getWidth() - 50),
            y = love.graphics.getHeight() + 50,
            category = randomCategory,
            image = (randomCategory == "Solar-Powered") and solarItems[love.math.random(#solarItems)] or
                nonSolarItems[love.math.random(#nonSolarItems)],
            width = 50, -- Set the width of the object image
            height = 50 -- Set the height of the object image
        }
        table.insert(objects, newObject)
    end

    -- Move objects
    for i, object in ipairs(objects) do
        object.y = object.y - 100 * dt
        if object.y < -50 then
            table.remove(objects, i)
        end
    end

    -- Check for mouse clicks
    if love.mouse.isDown(1) and not clickedThisFrame then
        local mx, my = love.mouse.getPosition()
        for i, object in ipairs(objects) do
            local imageWidth, imageHeight = object.image:getDimensions()
            if mx >= object.x and mx <= object.x + imageWidth  and my >= object.y and
                my <= object.y + imageHeight then
                clickedThisFrame = true -- Mark the click as processed
                if object.category == "Solar-Powered" then
                    score = score + 1
                    feedback = "Correct!"
                    sounds.success:play() -- Play the success sound
                else
                    score = score - 1
                    feedback = "Incorrect!"
                    sounds.error:play() -- Play the error sound
                end
                table.remove(objects, i)
                break -- Exit the loop after removing one clicked object
            end
        end
    elseif not love.mouse.isDown(1) then
        clickedThisFrame = false -- Reset the flag when the mouse button is released
    end
end

function Minigame:draw()
    -- Draw the game elements
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(),
        love.graphics.getHeight() / background:getHeight())
    love.graphics.print("Time: " .. math.ceil(timer), 10, 10)
    love.graphics.print("Score: " .. score, 10, 30)
    love.graphics.print(feedback, 10, 50)

    for i, object in ipairs(objects) do
        local targetWidth = 100 -- Set the desired width
        local targetHeight = 100 -- Set the desired height
        local imageWidth, imageHeight = object.image:getDimensions()
        local scale_x = targetWidth / imageWidth
        local scale_y = targetHeight / imageHeight
        love.graphics.draw(object.image, object.x, object.y, 0, scale_x, scale_y)
    end
end

function Minigame:unload()
    -- Clean up and release resources
end

return Minigame
