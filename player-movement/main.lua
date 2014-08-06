function love.load()
  player = {
    grid_x = 64,
    grid_y = 64,
    act_x = 64,
    act_y = 64,
    speed = 8
  }

  block = {
    size = 32
  }

  map = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 },
    { 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
  }

  character_actions = {
    up = function(character)
      if testMap(0, -1) then
        character.grid_y = character.grid_y - block.size
      end
    end,
    down = function(character)
      if testMap(0, 1) then
        character.grid_y = character.grid_y + block.size
      end
    end,
    left = function(character)
      if testMap(-1, 0) then
        character.grid_x = character.grid_x - block.size
      end
    end,
    right = function(character)
      if testMap(1, 0) then
        character.grid_x = character.grid_x + block.size
      end
    end
  }

end

function love.draw()
  drawMap()
  drawPlayer()
  drawStats()
end

function love.update(dt)
  player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
  player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)
end

function love.keypressed(key)
  if type(character_actions[key]) == "function" then
    character_actions[key](player)
  end
end

function testMap(x_delta, y_delta)
  if map[(player.grid_y / block.size) + y_delta][(player.grid_x / block.size) + x_delta] == 1 then
    return false
  end
  return true
end

function drawBlock(x, y)
  love.graphics.rectangle("line", x * block.size, y * block.size, block.size, block.size)
end

function drawPlayer()
  love.graphics.rectangle("fill", player.act_x, player.act_y, block.size, block.size)
end

function drawStats()
  local px_coord = string.format("P X: %s", player.grid_x)
  local py_coord = string.format("P Y: %s", player.grid_y)
  local pxact_coord = string.format("X Act: %s", player.act_x)
  local pyact_coord = string.format("Y Act: %s", player.act_x)

  love.graphics.print(px_coord, 620, 550)
  love.graphics.print(py_coord, 620, 550 + 12)
  love.graphics.print(pxact_coord, 620, 550 + (12 * 2))
  love.graphics.print(pyact_coord, 620, 550 + (12 * 3))
end

function drawMap() 
  for y=1, #map do
    for x=1, #map[y] do
      if map[y][x] == 1 then
        drawBlock(x, y)
      end
    end
  end
end
