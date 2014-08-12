object = {
  x = 50,
  y = 50,
  x_pos = true,
  y_pos = true,
  red = 0,
  green = 255,
  blue = 0,
  speed = 500,
  radius = 50,
}

function object:move_to(x, y)
  self.x = x
  self.y = y
end

function object:randomize_direction()
  self.x_pos = math.random(1, 2) == 1
  self.y_pos = math.random(1, 2) == 1
end

function object:randomize_color()
  self.red = math.random(0, 255)
  self.green = math.random(0, 255)
  self.blue = math.random(0, 255)
end

function object:determine_direction(width, height)
  if (self.x + self.radius + 1) >= width then
    self:randomize_color()
    self.x_pos = false 
  end

  if (self.x - self.radius) <= 0 then
    self:randomize_color()
    self.x_pos = true
  end

  if (self.y + self.radius + 1) >= height then
    self:randomize_color()
    self.y_pos = false 
  end

  if (self.y - self.radius) <= 0 then
    self:randomize_color()
    self.y_pos = true
  end
end

function object:move(difference)
  if self.x_pos then
    self.x = self.x + difference 
  else
    self.x = self.x - difference
  end

  if self.y_pos then
    self.y = self.y + difference
  else
    self.y = self.y - difference
  end
end

function object:draw(graphics)
  graphics.setColor(self.red, self.green, self.blue)
  graphics.circle("fill", self.x, self.y, self.radius, 50)
end

function love.load()
  love.graphics.setNewFont(26)
  love.graphics.setBackgroundColor(25, 25, 25)

  math.randomseed(os.time())
end

function love.update(dt)
  width, height = love.graphics.getDimensions()
  difference = object.speed * dt
  object:determine_direction(width, height)
  object:move(difference)
end

function love.mousepressed(x, y, button)
  width, height = love.graphics.getDimensions()
  if (x + object.radius) > width then
    x = width - object.radius
  end

  if x < 0 + object.radius then
    x = object.radius + 1 
  end

  if y < 0 + object.radius then
    y = object.radius + 1 
  end

  if (y + object.radius) > height then
    y = height - object.radius
  end

  object:move_to(x, y)
  object:randomize_direction()
  object:randomize_color()
end

function love.draw()
  object:draw(love.graphics)
end
