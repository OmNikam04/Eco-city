SolarMini = Class {
    __includes = BaseState
}

function SolarMini:init()
    
    --self.image = love.graphics.newImage('sprites/SolarMinis.jpg')
end

function SolarMini:update(dt)


    if love.keyboard.wasPressed('return') then
        if fixedSolar1 == false and gcol1 == true then
            fixedSolar1 = true
            gtasks = gtasks + 1
        end
        if fixedSolar2 == false and gcol2 == true then
            fixedSolar2 = true
            gtasks = gtasks + 1
        end
        gStateStack:pop()
        -- gStateStack:push(MainMenu())
    end

end

function SolarMini:render()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Press Enter to place",100,100)
    --love.graphics.draw(self.image, 0, 0)

end
