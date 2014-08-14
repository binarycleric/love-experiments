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
end

function love.draw()
  Background.drawWorld(world)
  Background.drawHud()
end
