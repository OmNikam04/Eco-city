DialogueState = Class {
    __includes = BaseState
}

local store_y = 100

function DialogueState:init()
    -- glevel = glevel + 1

    self.text = {

        [1] = {"In the heart of Greenvale, where nature and technology once ",
               "thrived side by side, a shadow now looms.",
               "The city's renewable energy resources lay dormant.","\n",
               "Your quest: explore the city",
               "and complete tasks to bring back electricity in the city.", "\n"},
        [2] = {"A windmill is a powerful machine that harnesses the energy from the ",
               "wind to generate electricity or mechanical power.",
               "The first wind farms in India were installed in the year",
               "Currently the windmill has been deactivated due to inactivity","\n",
               "Your quest: Fix the windmill by solving the maze"},
        [3] = {"A dam is a man-made structure that blocks the flow of a river.",
               "It's used for generating hydroelectric power. The first hydroelectric",
               "power plant in India was installed in Darjeeling, West Bengal.",
                "The Dam has not been started since 3 years","\n",
                "Your quest: Activate the dam by clearing the blockage"},
        [4] = {"Solar panels are devices that convert sunlight into electricity.",
               "They provide clean and renewable energy.",
               "India's first solar power plant was developed by Godawari Green ",
               "Limited in Rajasthan.This area has been receiving a ",
               "good amount of solar energy.","\n",
                "Your quest: Place Solar panels in the area"}
    }

    self.currentText = ""
    self.currentIndex = 1
    self.timer = 0
    self.typingSpeed = 0.045

    -- self.typing = love.audio.newSource('music/typing.mp3', 'static')
    -- self.typing:setVolume(0.1)

    self.delay = 0.3
    self.speed = 0

    -- Concatenate all the elements in text2[0] to currentText
    for i = 1, #self.text[glevel] do
        print(self.currentText)
        self.currentText = self.currentText .. self.text[glevel][i] .. "\n" -- Add a newline between elements
    end

    -- self.typing = love.audio.newSource('music/typing.mp3', 'static')
    -- self.typing:setVolume(0.1)

    -- self.image = love.graphics.newImage('sprites/credits.jpg')
end

function DialogueState:update(dt)
    -- timer = timer + dt
    self.timer = self.timer + dt

    -- Check if it's time to display the next character
    if self.timer >= self.typingSpeed and self.currentIndex <= #self.currentText then
        -- currentText2 = currentText2:sub(currentIndex2, currentIndex2)

        if string.match(self.currentText:sub(self.currentIndex, self.currentIndex), "%\n") then
            -- self.typing:stop()
            if self.speed < self.delay then
                self.speed = self.speed + dt
            else
                self.timer = 0
                self.currentIndex = self.currentIndex + 1
                self.speed = 0
            end
        else
            -- self.typing:stop()
            -- self.typing:play()
            self.timer = 0
            self.currentIndex = self.currentIndex + 1
        end

    end

    if love.keyboard.wasPressed('return') then
        if self.currentIndex <= #self.currentText then
            -- If the text is not fully displayed, show the entire text immediately
            if self.currentIndex == #self.currentText then
                -- self.typing:stop()
            end
            self.currentIndex = #self.currentText + 1

        else
            -- If the text is fully displayed, proceed to the next state
            if glevel == 2 then
                gStateStack:pop()
                print("Yes Reached")
                gStateStack:push(Windmill_Mini())
            elseif glevel == 3 then
                gStateStack:pop()
                print("Yes Reached")
                gStateStack:push(HydroMini())
            elseif glevel == 4 then
                gStateStack:pop()
                print("Yes Reached")
                gStateStack:push(SolarMini())
            else
                gStateStack:pop()
            end

            -- if glevel == 4 then
            --     gStateStack:pop()
            --     gStateStack:pop()
            --     gStateStack:push(MainMenu())
            -- else
            --     gStateStack:pop()
            -- end
        end

    end
end

function DialogueState:render()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Dialogue State", 300, 100)
    -- love.graphics.draw(self.image, 0, 0) 

    -- love.graphics.setBackgroundColor(1, 1, 1, 0.2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont("font.otf", 24)) -- Adjust font size as desired
    -- love.graphics.print(currentText, 100, 100)
    love.graphics.setLineWidth(5)
    love.graphics.rectangle('line', 40, 80, 1280 - 80, 270, 30)
    love.graphics.setColor(0.05, 0.05, 0.05)
    love.graphics.rectangle('fill', 40, 80, 1280 - 80, 270, 30)
    love.graphics.setColor(0, 0.9, 0.9)
    love.graphics.print(self.currentText:sub(1, self.currentIndex), 50, store_y)

end
