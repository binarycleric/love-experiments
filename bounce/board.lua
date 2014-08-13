Board = {}

function Board:new(board)
  local defaults = {
    balls = {},
  }
  local board = board or {} -- create object if user does not provide one
  for k,v in pairs(defaults) do
    if not board[k] then
      board[k] = v
    end
  end
  setmetatable(board, self)
  self.__index = self
  return board
end

function Board:setup(graphics)
  graphics.setNewFont(26)
  graphics.setBackgroundColor(25, 25, 25) 
end

function Board:add_ball(ball)
  ball:randomize_direction()
  ball:randomize_color()

  self.balls[#self.balls+1] = ball 
end

function Board:update(graphics, dt)
  local width, height = graphics.getDimensions()

  for index, ball in pairs(self.balls) do
    difference = ball.speed * dt

    ball:determine_direction(width, height)
    ball:move(difference)
  end
end

function Board:draw(graphics)
  local width, height = graphics.getDimensions()

  for index, ball in pairs(self.balls) do
    if (ball.x + ball.radius) >= width then
      ball.x = width - ball.radius
    end

    if (ball.y + ball.radius) >= height then
      ball.y = height - ball.radius
    end
  
    ball:draw(graphics)
  end
end
