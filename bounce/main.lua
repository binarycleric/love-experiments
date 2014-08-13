require "ball"
require "board"

function love.load()
  math.randomseed(os.time())

  local ball = Ball:new({
    x = 50,
    y = 50,
    radius = 50,
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
    radius = 50,
  })
  board:add_ball(ball)
end

function love.draw()
  board:draw(love.graphics)
end
