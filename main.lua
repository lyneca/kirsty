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
  speed = 4,
}
d = 0

function player.update(dt)
  if love.keyboard.isDown('left') then
    player.vx = player.vx - player.speed
  end
  if love.keyboard.isDown('right') then
    player.vx = player.vx + player.speed
  end
  player.vx = player.vx * FRICTION
  player.x = player.x + player.vx
  if player.y + player.h <= SCREEN_HEIGHT then
    player.vy = player.vy + GRAVITY * dt
    player.y = player.y + player.vy
  end
end

function love.load()

end

function love.update(dt)
  player.update(dt)
end

function love.draw()
  love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end
