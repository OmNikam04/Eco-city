
require 'src/Dependencies'
glevel = 0

fixedWindmill = false
fixedHydro = false
fixedSolar1 = false
fixedSolar2 = false

function love.load()

    love.window.setTitle("EcoCraft Challenge")
    local displayWidth, displayHeight = love.window.getDesktopDimensions()
    love.window.setMode(displayWidth, displayHeight, {fullscreen = false})
    
    wf = require 'lib/windfield/windfield'
    world = wf.newWorld(0, 0, false)

    -- anim8 = require 'lib/anim8/anim8'

    sti = require 'lib/Simple-Tiled-Implementation/sti'
    cameraFile = require 'lib/hump/camera'

    world:setQueryDebugDrawing(true)
    world:addCollisionClass('Player')
    world:addCollisionClass('Platform')
    world:addCollisionClass('Chair')
    world:addCollisionClass('Dam')
    world:addCollisionClass('Windmill')

    love.window.setMode(VIRTUAL_WIDTH,VIRTUAL_HEIGHT)

    math.randomseed(os.time())
    print(os.time())

      -- keep track of keypressed
    cam = cameraFile()
    
    love.keyboard.keysPressed={}
    gStateStack = StateStack()
    gStateStack:push(MainMenu())
    cam:zoom(3.5)

   
end

function love.update(dt)
    gStateStack:update(dt)
    love.keyboard.keysPressed={}
end

-- function love.resize(w, h)
--     push:resize(w, h)
-- end

function love.keypressed(key)
   if key == 'escape' then
       love.event.quit()
   end
   if glevel == 2 and fixedWindmill == false then
     if key == "w" then
        if collide(-1, 0) then
           player.grid_y = player.grid_y - 1
        end
     elseif key == "s" then
        if collide(1, 0) then
           player.grid_y = player.grid_y + 1
        end
     elseif key == "a" then
        if collide(0, -1) then
           player.grid_x = player.grid_x - 1
        end
     elseif key == "d" then
        if collide(0, 1) then
           player.grid_x = player.grid_x + 1
        end
     elseif key == 'escape' then
        love.event.push('quit')
     end
  end
   love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()

    --push:start()
    --love.graphics.setColor(0.1,0.1,0.1)
    --love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)  
    gStateStack:render()
    
    --push:finish()

end

-- collision conditions, if overlap happens then collision is true --
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end



