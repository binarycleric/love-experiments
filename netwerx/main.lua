local socket = require 'socket' 
local address, port = "localhost", 12345

local entity 
local updaterate = 0.1

local world = {}
local t

function love.load()
  udp = socket.udp()

  udp:settimeout(0)
  udp:setpeername(address, port)

  math.randomseed(os.time()) 
  entity = tostring(math.random(99999))

  local dg = string.format("%s %s %d %d", entity, 'at', 320, 240)
  udp:send(dg) -- the magic line in question.
  
  -- t is just a variable we use to help us with the update rate in love.update.
  t = 0 -- (re)set t to 0
end

function love.update(deltatime)
  t = t + deltatime -- increase t by the deltatime
  
  if t > updaterate then
    local x, y = 0, 0
    if love.keyboard.isDown('up') then  
      y = y - (20 * t) 
    end

    if love.keyboard.isDown('down') then
      y = y + (20 * t) 
    end

    if love.keyboard.isDown('left') then    
      x = x - (20 * t) 
    end

    if love.keyboard.isDown('right') then   
      x = x + (20 * t) 
    end

    local dg = string.format("%s %s %f %f", entity, 'move', x, y)
    udp:send(dg)

    local dg = string.format("%s %s $", entity, 'update')
    udp:send(dg)

    t = t - updaterate -- set t for the next round
  end

  repeat
    data, msg = udp:receive()

    if data then
      ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
      if cmd == 'at' then
        local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")

        assert(x and y)
        x, y = tonumber(x), tonumber(y)
        world[ent] = {x=x, y=y}
      else
        print("unrecognised command:", cmd)
      end
    elseif msg ~= 'timeout' then 
      error("Network error: "..tostring(msg))
    end
  until not data
end

function love.draw()
  -- pretty simple, we 
  for k, v in pairs(world) do
    love.graphics.print(k, v.x, v.y)
  end
end

