require "ball"
require "block"
require "background"
require "trap"

function love.load()
  love.graphics.setBackgroundColor(25, 25, 25) 
  love.window.setMode(800, 650)
  love.physics.setMeter(64)

  world = love.physics.newWorld(0, 9.81 * 64, true)

  Background.buildMap(world)
end

function love.update(dt)
  Background.update(world, dt)

  grav_x, grav_y = world:getGravity() 

  if love.keyboard.isDown("left") then
    grav_x = grav_x - 10 
  end
  if love.keyboard.isDown("right") then
    grav_x = grav_x + 10 
  end

  if love.keyboard.isDown("up") then
    grav_y = grav_y + 10
  end
  if love.keyboard.isDown("down") then
    grav_y = grav_y - 10
  end

  if love.keyboard.isDown("n") then
    Background.nukeBalls(world)
  end

  if love.keyboard.isDown("r") then
    grav_x = 0
    grav_y = 9.81 * 64
  end

  world:setGravity(grav_x, grav_y)
end

function love.draw()
  Background.drawWorld(world)
  Background.drawHud()
end
