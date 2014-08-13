-- slight modification of http://love2d.org/wiki/Tutorial:Physics
function love.load()
  love.graphics.setNewFont(26)

  --initial graphics setup
  love.graphics.setBackgroundColor(25, 25, 25) 
  love.window.setMode(800, 650)

  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81 * 64, true)

  -- creating the ground
  buildGround()

  -- creating the ball
  local ball_body = love.physics.newBody(world, 800/2, 650/2, "dynamic")
  local ball_shape = love.physics.newCircleShape(20)
  local ball_fixture = love.physics.newFixture(ball_body, ball_shape)
  ball_fixture:setRestitution(0.85)
  ball_body:setUserData("ball")

  -- creating some blocks
  local block1_body = love.physics.newBody(world, 200, 550, "dynamic")
  local block1_shape = love.physics.newRectangleShape(50, 100)
  local block1_fixture = love.physics.newFixture(block1_body, block1_shape, 5) 
  block1_body:setUserData("block")

  local block2_body = love.physics.newBody(world, 200, 400, "dynamic")
  local block2_shape = love.physics.newRectangleShape(100, 30)
  local block2_fixture = love.physics.newFixture(block2_body, block2_shape, 2)
  block2_body:setUserData("block")

  local block3_body = love.physics.newBody(world, 450, 600, "dynamic")
  local block3_shape = love.physics.newRectangleShape(50, 125)
  local block3_fixture = love.physics.newFixture(block3_body, block3_shape, 1)
  block3_body:setUserData("block")
end

function buildGround()
  local body = love.physics.newBody(world, 800/2, 650-50/2)
  local shape = love.physics.newRectangleShape(650, 50)
  local fixture = love.physics.newFixture(body, shape)
  body:setUserData("ground")

  local body = love.physics.newBody(world, 800/2, 0)
  local shape = love.physics.newRectangleShape(700, 25)
  local fixture = love.physics.newFixture(body, shape)
  body:setUserData("ground")

  local body = love.physics.newBody(world, 25, 25)
  local shape = love.physics.newRectangleShape(50, 815)
  local fixture = love.physics.newFixture(body, shape)
  body:setUserData("ground")

  local body = love.physics.newBody(world, 775, 25)
  local shape = love.physics.newRectangleShape(50, 815)
  local fixture = love.physics.newFixture(body, shape)
  body:setUserData("ground")
end

function love.update(dt)
  world:update(dt)
  local ball = getBallBody(world)

  if love.keyboard.isDown("right") then
    ball:applyForce(400, 0)
  elseif love.keyboard.isDown("left") then
    ball:applyForce(-400, 0)
  elseif love.keyboard.isDown("r") then
    ball:setPosition(800/2, 650/2)
  elseif love.keyboard.isDown("down") then
    ball:applyForce(0, 1000)
  end
end

function love.draw()
  for key, body in pairs(world:getBodyList()) do
    if body:getUserData() == "ground" then
      drawGround(body)
    elseif body:getUserData() == "ball" then
      drawBall(body)
    elseif body:getUserData() == "block" then
      drawBlock(body)
    end
  end
end

function getBallBody(world)
  for key, body in pairs(world:getBodyList()) do
    if body:getUserData() == "ball" then
      return body
    end
  end
end

function drawBlock(body)
  love.graphics.setColor(50, 50, 225)
  for key, fixture in pairs(body:getFixtureList()) do
    local shape = fixture:getShape()
    love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
  end
end

function drawGround(body)
  for key, fixture in pairs(body:getFixtureList()) do
    local shape = fixture:getShape()

    love.graphics.setColor(210, 210, 245)
    love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
  end
end

function drawBall(body)
  love.graphics.setColor(193, 47, 14)
  for key, fixture in pairs(body:getFixtureList()) do
    local shape = fixture:getShape()
    love.graphics.circle("fill", body:getX(), body:getY(), shape:getRadius())
  end
end

