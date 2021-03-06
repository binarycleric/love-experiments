Trap = {}

Trap.create = function(world, x, y, size)
  local body = love.physics.newBody(world, x, y)
  local shape = love.physics.newRectangleShape(0, 0, 60, 5, 0)
  local fixture = love.physics.newFixture(body, shape)

  local attributes = {
    object_type = "trap",
    color = {
      red = 255,
      green = 0,
      blue = 250
    }
  }
  body:setUserData(attributes)
end

Trap.draw = function(body)
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

Trap.beginContact = function(trap, ball, contact)
  if(trap:getBody():getUserData().object_type == "trap") then
    if(ball:getBody():getUserData().object_type == "ball") then
      ball:getBody():destroy()
      Background.score = Background.score + 1
    end
  end
end
