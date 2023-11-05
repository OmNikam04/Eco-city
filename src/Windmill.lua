Windmill = Class {
    __includes = BaseState
}

function Windmill:init()
    self.mill = world:newRectangleCollider(400, 1580, 10, 10)
    self.mill.image = love.graphics.newImage('sprites/windmill.png')
    self.mill:setType('static')
    self.mill.spritesheet = love.graphics.newImage('sprites/windmill_spritesheet.png')
    self.mill.grid = anim8.newGrid(398, 512, self.mill.spritesheet:getWidth(), self.mill.spritesheet:getHeight())
    self.mill.animation = {}
    self.mill.animation.rotating = anim8.newAnimation(self.mill.grid('1-4', 1), 0.08)
end

function Windmill:update(dt)
    self.mill.animation.rotating:update(dt)
end

function Windmill:render()

    if fixedWindmill == true then
        for x = 1, 3 do
            for y = 1, 3 do
                self.mill.animation.rotating:draw(self.mill.spritesheet,self.mill:getX() - 10 + x*40, self.mill:getY() - 10 + y*40, nil, 0.1)
            end
        end
    else
        for x = 1, 3 do
            for y = 1, 3 do
                love.graphics.draw(self.mill.image, self.mill:getX() + x*40, self.mill:getY() + y*60, nil, 0.1)
            end
        end
    end

end