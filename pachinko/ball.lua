Ball = {}

Ball.create = function(world, x, y, size)
  local body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newCircleShape(size)
  local fixture = love.physics.newFixture(body, shape)

  local attributes = {
    object_type = "ball",
    color = {
      red = math.random(0, 255),
      green = math.random(0, 255), 
      blue = math.random(0, 255)
    }
  }

  fixture:setRestitution(0.85)
  body:setUserData(attributes)

  return body
end

-- Not great. Could be a lot better.
Ball.getCount = function(would)
  local i = 0
  for key, body in pairs(world:getBodyList()) do
    if body:getUserData().object_type == "ball" then
      i = i + 1
    end
  end

  return i
end

Ball.draw = function(body)
  local color = body:getUserData().color
  love.graphics.setColor(color.red, color.green, color.blue)
  for key, fixture in pairs(body:getFixtureList()) do
    local shape = fixture:getShape()
    love.graphics.circle(
      "fill", 
      body:getX(), 
      body:getY(), 
      shape:getRadius()
    )
  end
end
