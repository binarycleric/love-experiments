function love.load()
  love.graphics.setNewFont(26)
  love.graphics.setColor(0,255,0)
  love.graphics.setBackgroundColor(25, 25, 25)

  point = {
    x = 0,
    y = 0
  }
  clicks = 0
  player_size = 5
  pause = false
end

function love.update(dt)
  if paused ~= true then
    if love.keyboard.isDown("up") then
      point.y = point.y - (100 * dt)
    end

    if love.keyboard.isDown("down") then
      point.y = point.y + (100 * dt)
    end

    if love.keyboard.isDown("left") then
      point.x = point.x - (100 * dt)
    end

    if love.keyboard.isDown("right") then
      point.x = point.x + (100 * dt)
    end
  end
end

function love.draw()
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill", 5, 5, 200, 100)

  love.graphics.setColor(0,255,0)
  love.graphics.print(string.format("X : %.2f", point.x), 10, 10)
  love.graphics.print(string.format("Y : %.2f", point.y), 10, 30)
  love.graphics.print(string.format("Clicks : %s", clicks), 10, 50)

  if paused == true then
    love.graphics.setNewFont(52)
    love.graphics.print("PAUSED", 250, 250)
    love.graphics.setNewFont(26)
  end
 
  love.graphics.rectangle("fill", point.x, point.y, player_size, player_size)
end

function love.mousepressed(x, y, button)
  if paused ~= true then
    clicks = clicks + 1

    if point.x == x and point.y == y then
      player_size = 100
    end

    point.x = x
    point.y = y
  end
end

function love.keyreleased(key)
  if key == 'a' then
    paused = not paused
  end
end

function love.mousereleased(x, y, button)
  if paused ~= true then
    player_size = 5
  end
end

function love.focus(f)
  if not f and not paused then
    paused = true
  end
end

function love.quit()
  print("\nI know it sucked. :(")
end
