Ball = {}

function Ball:new(o)
  local defaults = {
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

  local o = o or {} -- create object if user does not provide one
  for k,v in pairs(defaults) do
    if not o[k] then
      o[k] = v
    end
  end
  setmetatable(o, self)
  self.__index = self
  return o
end

function Ball:move_to(x, y)
  self.x = x
  self.y = y
end

function Ball:randomize_direction()
  self.x_pos = math.random(1, 2) == 1
  self.y_pos = math.random(1, 2) == 1
end

function Ball:randomize_color()
  self.red = math.random(0, 255)
  self.green = math.random(0, 255)
  self.blue = math.random(0, 255)
end

function Ball:determine_direction(width, height)
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

function Ball:move(difference)
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

function Ball:draw(graphics)
  graphics.setColor(self.red, self.green, self.blue)
  graphics.circle("fill", self.x, self.y, self.radius, 50)
end
