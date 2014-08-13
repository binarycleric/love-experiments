require "ball"
require "board"

function love.load()
  local width, height = love.graphics.getDimensions()
  math.randomseed(os.time())

  local ball = Ball:new({
    x = math.random(0, width),
    y = math.random(0, height),
    radius = math.random(25,100),
    speed = math.random(250, 800),    
  })

  board = Board:new()
  board:setup(love.graphics)
  board:add_ball(ball)
end

function love.update(dt)
  board:update(love.graphics, dt)
end

function love.mousepressed(mouse_x, mouse_y, button)
  local ball = Ball:new({
    x = mouse_x,
    y = mouse_y,
    radius = math.random(25,100),
    speed = math.random(250, 800),
  })
  board:add_ball(ball)
end

function love.draw()
  board:draw(love.graphics)

  love.graphics.setColor(255, 255, 255)
  love.graphics.print(string.format("Balls : %s", #board.balls), 10, 10)
  love.graphics.print(string.format("FPS : %s", love.timer.getFPS()), 10, 35)
end
