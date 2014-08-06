function love.load()
  player = {
    grid_x = 64,
    grid_y = 64,
    act_x = 64,
    act_y = 64,
    speed = 8
  }

  map = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
    { 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 },
    { 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 },
    { 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 }, -- give the player a door.
    { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1 },
    { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
  }
end

function love.draw()
  for y=1, #map do
    for x=1, #map[y] do
      if map[y][x] == 1 then
        love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
      end
    end
  end

  love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)

  local px_coord = string.format("Player X: %s", player.grid_x)
  local py_coord = string.format("Player Y: %s", player.grid_y)

  love.graphics.print(px_coord, 700, 550)
  love.graphics.print(py_coord, 700, 550 + 12)
end

function love.update(dt)
  player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
  player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)
end

function love.keypressed(key)
  local actions = {
    up = function()
      if testMap(0, -1) then
        player.grid_y = player.grid_y - 32
      end
    end,
    down = function()
      if testMap(0, 1) then
        player.grid_y = player.grid_y + 32
      end
    end,
    left = function()
      if testMap(-1, 0) then
        player.grid_x = player.grid_x - 32
      end
    end,
    right = function()
      if testMap(1, 0) then
        player.grid_x = player.grid_x + 32
      end
    end
  }

  if type(actions[key]) == "function" then
    actions[key](player)
  end
end

function testMap(x, y)
  if map[(player.grid_y / 32) + y][(player.grid_x / 32) + x] == 1 then
    return false
  end
  return true
end
