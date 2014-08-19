function love.load()
  scale_x = 0.0
  scale_y = 0.0
end

function love.update(dt)
  if scale_x < 5.0 then
    scale_x = scale_x + 0.01
  end

  if scale_y < 5.0 then
    scale_y = scale_y + 0.01
  end
end

function love.draw()
  love.graphics.push()   
  love.graphics.scale(scale_x, scale_y)
  love.graphics.print("Scaled text", 50, 50)   
  love.graphics.pop()   
  love.graphics.print("Normal text", 50, 50)
end
