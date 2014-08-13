require "ball"
require "board"

function love.load()
  local width, height = love.graphics.getDimensions()
  math.randomseed(os.time())

  local start_radius = math.random(25, 100)
  local start_x = math.random(0, width)
  local start_y = math.random(0, height)
  
  -- TODO: remove this and add sanity checks to update method.
  if start_x < start_radius then
    start_x = start_x + start_radius
  end

  if start_y < start_radius then
    start_y = start_y + start_radius
  end

  local ball = Ball:new({
    x = start_x,
    y = start_y,
    radius = start_radius,
    speed = math.random(250, 800),    
  })
  ball:randomize_direction()
  ball:randomize_color()

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
  ball:randomize_direction()
  ball:randomize_color()

  board:add_ball(ball)
end

function love.draw()
  board:draw(love.graphics)

  love.graphics.setColor(255, 255, 255)
  love.graphics.print(string.format("Balls : %s", #board.balls), 10, 10)
  love.graphics.print(string.format("FPS : %s", love.timer.getFPS()), 10, 35)
end
