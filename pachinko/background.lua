Background = {
  -- how many seconds since we last garbage collected
  last_gc = 0,
  -- the player's current score
  score = 0
}

Background.buildMap = function(world)
  Block.create(world, 100, 100, 20, 20)
  Block.create(world, 175, 100, 20, 20)
  Block.create(world, 250, 100, 20, 20)
  Block.create(world, 325, 100, 20, 20)
  Block.create(world, 400, 100, 20, 20)
  Block.create(world, 475, 100, 20, 20) 

  Block.create(world, 100+50, 200, 20, 20)
  Block.create(world, 175+50, 200, 20, 20)
  Block.create(world, 250+50, 200, 20, 20)
  Block.create(world, 325+50, 200, 20, 20)
  Block.create(world, 400+50, 200, 20, 20)
  Block.create(world, 475+50, 200, 20, 20) 

  Block.create(world, 100-25, 300, 20, 20)
  Block.create(world, 175-25, 300, 20, 20)
  Block.create(world, 250-25, 300, 20, 20)
  Block.create(world, 325-25, 300, 20, 20)
  Block.create(world, 400-25, 300, 20, 20)
  Block.create(world, 475-25, 300, 20, 20) 

  Trap.create(world, 100, 575) 
  Trap.create(world, 100+250, 575)
  Trap.create(world, 100+250+250, 575)

  world:setCallbacks(Trap.beginContact)
end

Background.garbageCollect = function(world)
  for key, body in pairs(world:getBodyList()) do
    if body:getUserData().object_type == "ball" then
      if body:getX() > 850 or body:getY() > 675 then
        body:destroy()
      end
    end
  end
end

Background.update = function(world, dt)
  world:update(dt)

  for i = 0, math.random(0, 3), 1 do
    Ball.create(world, math.random(300, 350), -1, 5)  
  end

  Background.last_gc = Background.last_gc + dt
  if Background.last_gc >= 1 then
    Background.garbageCollect(world)
    Background.last_gc = 0
  end
end

Background.drawHud = function()
  love.graphics.setNewFont(26)
  love.graphics.setColor(255, 255, 255)

  love.graphics.print(string.format("Balls : %s", Ball.getCount(world)), 10, 10)
  love.graphics.print(string.format("FPS : %s", love.timer.getFPS()), 10, 40)
  love.graphics.print(string.format("Score : %s", Background.score), 10, 70)
end

Background.drawWorld = function(world)
  for key, body in pairs(world:getBodyList()) do
    if body:getUserData().object_type == "ball" then
      Ball.draw(body)
    elseif body:getUserData().object_type == "block" then
      Block.draw(body)
    elseif body:getUserData().object_type == "trap" then
      Trap.draw(body)
    end
  end
end
