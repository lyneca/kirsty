FRICTION = 0.8
GRAVITY = 9.8
SCREEN_HEIGHT = 600
SCREEN_WIDTH = 800
player = {
  x = 50,
  y = 50,
  w = 50,
  h = 70,
  vx = 0,
  vy = 0,
  jump_speed = 6,
  speed = 4,
  is_touching_ground = false,
}
debug = ''
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

end

function love.update(dt)
  player.update(dt)
end

function love.draw()
  love.graphics.print(tostring(player.is_touching_ground), 0, 0)
  love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end
