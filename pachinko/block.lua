Block = {}

Block.create = function(world, x, y, size_x, size_y, angle)
  angle = angle or 0 

  local body = love.physics.newBody(world, x, y)
  local shape = love.physics.newRectangleShape(0, 0, size_x, size_y, angle)
  local fixture = love.physics.newFixture(body, shape)

  local attributes = {
    object_type = "block",
    color = {
      red = 0,
      green = 0,
      blue = 250
    }
  }
  body:setUserData(attributes)
  
end

Block.draw = function(body)
  local color = body:getUserData().color
  love.graphics.setColor(color.red, color.green, color.blue)
  for key, fixture in pairs(body:getFixtureList()) do
    local shape = fixture:getShape()
    love.graphics.polygon(
      "fill", 
      body:getWorldPoints(shape:getPoints())
    )
  end
end
