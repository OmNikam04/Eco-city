-- Import the required modules
local anim8 = require 'libraries/anim8'

-- Define the Player class
local Player = {}
Player.__index = Player

-- Constructor for the Player
function Player.create(from, to)
    local self = setmetatable({}, Player)
    self.x = 400
    self.y = 200
    self.speed = 6
    self.spriteSheet = love.graphics.newImage('assets/images/01-generic.png')
    self.grid = anim8.newGrid(16, 16, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    self.animation = {}
    self.animation.down = anim8.newAnimation(self.grid(from ..'-'..to, 1), 0.2)
    self.animation.right = anim8.newAnimation(self.grid(from ..'-'..to, 3), 0.2)
    self.animation.up = anim8.newAnimation(self.grid(from ..'-'..to, 4), 0.2)
    self.animation.left = anim8.newAnimation(self.grid(from ..'-'..to, 2), 0.2)
    
    -- Initialize the animation
    self.anim = self.animation.down
    self.anim:gotoFrame(1) -- Set the initial frame

    return self
end

-- Update function for the Player
function Player:update(dt)
    -- Add player movement and other logic here

    local isMoving = false
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed
        self.anim = self.animation.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed
        self.anim = self.animation.left
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed
        self.anim = self.animation.up
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed
        self.anim = self.animation.down
        isMoving = true
    end

    if isMoving == false then
        -- use 2nd frame of each row which indicates the still standing position of the object
        self.anim:gotoFrame(2)
    end

    self.anim:update(dt)
end

-- Draw function for the Player
function Player:draw()
    self.anim:draw(self.spriteSheet, self.x, self.y, nil, 6)
end

-- Define other methods or functions for the Player class

return Player
