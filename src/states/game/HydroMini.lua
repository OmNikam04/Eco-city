HydroMini = Class {
    __includes = BaseState
}

function HydroMini:init()

    --self.image = love.graphics.newImage('sprites/HydroMinis.jpg')
    self.player = {}
    self.player.width = 50
    self.player.height = 50
    self.player.x = VIRTUAL_WIDTH/2 - self.player.width/2
    self.player.y = VIRTUAL_HEIGHT - self.player.height
    self.player.speed = 200
    
    self.manyenemies = {}
    self.image =  love.graphics.newImage("sprites/stones.png")
    for i = 1, 5 do
        for j = 1, 11
         do
            local enemy = {}
            enemy.x = j * 60
            enemy.y = i * 60 - 60
            enemy.width = 50
            enemy.height = 50
            table.insert(self.manyenemies, enemy)
        end
    end

    self.manybullets = {}
end

function HydroMini:update(dt)

    

    -- if love.keyboard.wasPressed('return') then
    --     gStateStack:pop()
    --     gStateStack:push(MainMenu())
    -- end

    if love.keyboard.wasPressed("space") then
        table.insert(self.manybullets, self:createbullets())
    end

    if love.keyboard.isDown("right") then
        self.player.x = math.min(VIRTUAL_WIDTH - self.player.width, self.player.x + self.player.speed*dt)
    end

    if love.keyboard.isDown("left") then
        self.player.x = math.max(0, self.player.x - self.player.speed*dt)
    end

    for i, v in pairs(self.manybullets) do
        v.y = v.y - v.speed*dt
    end

    for i, v in pairs(self.manybullets) do
        if v.y < -v.height then
            table.remove(self.manybullets, i)
        end
    end

    for i, v in pairs(self.manybullets) do
        for j, k in pairs(self.manyenemies) do
            if checkCollision(v.x, v.y, v.width, v.height, k.x, k.y, k.width, k.height) then
                table.remove(self.manyenemies, j)
                table.remove(self.manybullets, i)
            end
        end
    end

    if #self.manyenemies == 0 then
        fixedHydro = true
        gtasks = gtasks + 1
        gStateStack:pop()
    end
end

function HydroMini:render()

    love.graphics.setColor(0, 0.7, 0.9, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0.5, 0.8, 0.8, 1)
    love.graphics.rectangle('fill', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.setColor(0, 0, 0, 1)
    for key, value in ipairs(self.manyenemies) do
        love.graphics.draw(self.image, value.x, value.y, nil, 0.2)
        -- love.graphics.rectangle('line', value.x, value.y, value.width, value.height)
    end

    love.graphics.setColor(0, 0.5, 0, 1)

    for key, value in ipairs(self.manybullets) do
        love.graphics.rectangle('fill', value.x, value.y, value.width, value.height)
    end

    
    print(#self.manybullets)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Destroy All Stones", 350, 500)
    --love.graphics.draw(self.image, 0, 0)

end

function HydroMini:createbullets()

    local bullet = {}
    bullet.width = 10
    bullet.height = 10
    bullet.x = self.player.x + self.player.width/2 - bullet.width/2
    bullet.y = self.player.y
    bullet.speed = 400
    return bullet
end
