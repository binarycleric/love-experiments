require "ball"
require "block"

function love.load()
  love.graphics.setNewFont(26)

  love.graphics.setBackgroundColor(25, 25, 25) 
  love.window.setMode(800, 650)

  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81 * 64, true)

  -- how many seconds since we last garbage collected
  last_gc = 0

  Block.create(world, 250, 400, 0.1)
  Block.create(world, 200, 300, -0.85)

  Block.create(world, 512, 250, 0.5)
  Block.create(world, 600, 400, 0.25)

  Block.create(world, 325, 600, 0.15)
end

function love.update(dt)
  world:update(dt)
  for i = 0, 1, 1 do
    Ball.create(world, math.random(50, 750), -1, 5)  
  end

  last_gc = last_gc + dt

  if last_gc >= 1 then
    Ball.garbageCollect(world)
    last_gc = 0
  end
end

function love.draw()
  for key, body in pairs(world:getBodyList()) do
    if body:getUserData().object_type == "ball" then
      Ball.draw(love.graphics, body)
    elseif body:getUserData().object_type == "block" then
      Block.draw(love.graphics, body)
    end
  end

  love.graphics.setColor(255, 255, 255)
  love.graphics.print(string.format("Balls : %s", Ball.getCount(world)), 10, 10)
  love.graphics.print(string.format("FPS : %s", love.timer.getFPS()), 10, 40)
end
