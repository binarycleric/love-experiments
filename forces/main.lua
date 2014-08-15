function love.load()
  love.graphics.setBackgroundColor(25, 25, 25) 
  love.window.setMode(800, 650)
  
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81 * 64, true)


  player = {
    x = 100,
    y = 100
  }
  player_body = Player.create()
  ground_body = Ground.create()
end

function love.update(dt)
  if love.keyboard.isDown("w") then
    player_body:applyForce(0, -1000)
  end

  if love.keyboard.isDown("s") then
    player_body:applyForce(0, 1000)
  end

  if love.keyboard.isDown("d") then
    player_body:applyForce(1000, 0)
  end

  if love.keyboard.isDown("a") then
    player_body:applyForce(-1000, 0)
  end

  if love.keyboard.isDown("q") then
    player_body:applyTorque(1000)
  end

  world:update(dt)
end

function love.draw()

  Ground.draw(ground_body)
  Player.draw(player_body)
end

Ground = {}

Ground.create = function() 
  local body = love.physics.newBody(world, 400, 600)
  local shape = love.physics.newRectangleShape(800, 50)
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

  return body
end

Ground.draw = function(body)
  local color = body:getUserData().color
  love.graphics.setColor(color.red, color.green, color.blue)
  for key, fixture in pairs(body:getFixtureList()) do
    local shape = fixture:getShape()
    love.graphics.polygon(
      "line", 
      body:getWorldPoints(shape:getPoints())
    )
  end
end

Player = {}

Player.draw = function(body)
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

Player.create = function()
  local body = love.physics.newBody(world, player.x, player.y, "dynamic")
  local shape = love.physics.newRectangleShape(80 * 0.43, 80)
  local fixture = love.physics.newFixture(body, shape)

  local attributes = {
    object_type = "player",
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
