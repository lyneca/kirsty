require 'table'

FRICTION = 0.8
GRAVITY = 40
SCREEN_HEIGHT = 600
SCREEN_WIDTH = 800

player = {
  x = 50,
  y = 50,
  w = 50,
  h = 70,
  vx = 0,
  vy = 0,
  jump_speed = 15,
  speed = 4,
  is_touching_ground = false,
}

Platform = {
  x = 0,
  y = 0,
  w = 100,
  h = 25
}

platforms = {}

function Platform:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

function Platform:new(x, y)
  o = {}
  setmetatable(o, self)
  self.__index = self
  o.x = x
  o.y = y
  table.insert(platforms, o)
  return o
end

function love.keypressed(key)
  if key == 'up' then player.jump() end
end

function player.jump()
  debug = 'jumped'
  if player.is_touching_ground then
    player.vy = -player.jump_speed
  end
end

function love.keypressed(key)
  if key == 'up' then player.jump() end
end

function player.jump()
  debug = 'jumped'
  if player.is_touching_ground then
    player.vy = -player.jump_speed
  end
end

function player.update(dt)
  if love.keyboard.isDown('left') then
    player.vx = player.vx - player.speed
  end
  if love.keyboard.isDown('right') then
    player.vx = player.vx + player.speed
  end
  player.vx = player.vx * FRICTION
  player.x = player.x + player.vx
  player.y = player.y + player.vy
  for k, platform in ipairs(platforms) do
    if platform.x < player.x and player.x < platform.x + platform.w then
      if platform.y < player.y + player.h and player.y + player.h < platform.y  + platform.h then
        player.y = platform.y - player.h
        player.is_touching_ground = true
      end
    end
  end
  if player.y + player.h < SCREEN_HEIGHT then
    if player.is_touching_ground then
      player.is_touching_ground = false
    end
    player.vy = player.vy + GRAVITY * dt
  else
    if not player.is_touching_ground then
      player.is_touching_ground = true
      player.vy = 0
    end
  end
end

function love.load()
  Platform:new(40, 500)
end

function love.update(dt)
  player.update(dt)
end

function love.draw()
  for k, platform in ipairs(platforms) do
    platform:draw()
  end
  love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end
