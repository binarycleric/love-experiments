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
  Block.draw(body)
end

Trap.beginContact = function(trap, ball, contact)
  if(trap:getBody():getUserData().object_type == "trap") then
    if(ball:getBody():getUserData().object_type == "ball") then
      ball:getBody():destroy()
      Background.score = Background.score + 1
    end
  end
end
