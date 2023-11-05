Player = Class {
    __includes = BaseState
}
gcol1 = false
gcol2 = false

function Player:init()
    self.player = world:newRectangleCollider(1570, 35, 10, 10,{collision_class="Player"})
    self.player.speed=180
    self.player:setFixedRotation(true)
    self.player.isMoving = false
    self.player.direction = 1

    self.player.spritesheet = love.graphics.newImage('sprites/player_spritesheet.png')
    self.player.grid = anim8.newGrid(16, 16, self.player.spritesheet:getWidth(), self.player.spritesheet:getHeight())
    self.player.animation = {}
    self.player.animation.up = anim8.newAnimation(self.player.grid('1-3', 1), 0.1)
    self.player.animation.left = anim8.newAnimation(self.player.grid('1-3', 2), 0.1)
    self.player.animation.right = anim8.newAnimation(self.player.grid('1-3', 3), 0.1)
    self.player.animation.down = anim8.newAnimation(self.player.grid('1-3', 4), 0.1)

    self.player.anim = self.player.animation.left
    -- self.footstepsSound = love.audio.newSource('assets/sounds/footsteps.mp3', 'static')
    -- self.soundPlaying = false
end

function Player:update(dt)
    local px, py = self.player:getX(), self.player:getY()
    isMoving = false
    cam:lookAt(px, py)

    if love.keyboard.isDown("right") then
        self.player:setX(self.player:getX() + self.player.speed * dt)
        self.player.anim = self.player.animation.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        self.player:setX(self.player:getX() - self.player.speed * dt)
        self.player.anim = self.player.animation.left
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        self.player:setY(self.player:getY() - self.player.speed * dt)
        self.player.anim = self.player.animation.down
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        self.player:setY(self.player:getY() + self.player.speed * dt)
        self.player.anim = self.player.animation.up
        isMoving = true
    end

    if isMoving == false then
        self.player.anim:gotoFrame(2)
    end

    if fixedWindmill == false and checkCollision(px, py, 10, 10, 440, 1570, 100, 30) then
        glevel = 2
        -- self.player:setX(410)
        -- self.player:setY(350)
        gStateStack:push(DialogueState())
    end
    if fixedHydro == false and checkCollision(px, py, 10, 10, 1700, 177, 170, 60) then
        glevel = 3
        -- self.player:setX(376)
        -- self.player:setY(942)
        gStateStack:push(DialogueState())
    end
    if fixedSolar1 == false and checkCollision(px, py, 10, 10, 1136, 1519, 100, 50) then
        glevel = 4
        gcol1 = true
        -- self.player:setX(1122)
        -- self.player:setY(344)
        gStateStack:push(DialogueState())
        -- fixedSolar1 = true
    end

    if fixedSolar2 == false and checkCollision(px, py, 10, 10, 375, 13, 120, 30) then
        glevel = 4
        gcol2 = true
        -- self.player:setX(1770)
        -- self.player:setY(1050)
        gStateStack:push(DialogueState())
        -- fixedSolar2 = true
    end

    if gtasks == 4 then
        destroyAll()
        gStateStack:pop()
        gStateStack:push(Credit())
    end
    self.player.anim:update(dt)
 
end




function Player:render()
--    love.graphics.rectangle('fill', self.player:getX() - 8, self.player:getY() - 8, 16, 16)
self.player.anim:draw(self.player.spritesheet,self.player:getX() - 10, self.player:getY() - 10, nil, 1.3, 1.3)
-- print(glevel)
   
end
function destroyAll()
    local i =#platforms 
    local j =#chairs
    local k =#dams 
    local m =#windmills
    while i>-1 do 
        if platforms[i] ~= nil then 
            platforms[i]:destroy()
        end 
        table.remove(platforms,i)
        i=i-1
    end  
    while k>-1 do 
        if dams[k] ~= nil then 
            dams[k]:destroy()
        end 
        table.remove(dams,k)
        k=k-1
    end  
    while j>-1 do 
        if chairs[j] ~= nil then 
            chairs[j]:destroy()
        end 
        table.remove(chairs,j)
        j=j-1 
    end  

    while m>-1 do 
        if windmills[m] ~= nil then 
            windmills[m]:destroy()
        end 
        table.remove(windmills,m)
        m=m-1 
    end  

    -- for _, body in pairs(world:getBodies()) do
    --     body:destroy()
    -- end
end