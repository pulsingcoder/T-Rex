--[[
The PlayState class is the bulk of the game, where the player actually controls the bird and
avoids pipes. When the player collides with a pipe, we should go to the GameOver state, where
we then go back to the main menu.
]]

PlayState = Class{_includes = Base}
temp = 0
function PlayState:init()
self.dino = Dino()
self.sprites = {}
self.spawnTimer = 0
self.scoretime = 0
self.score = 0
end


function PlayState:update(dt)
sounds['terror']:setLooping(true)
sounds['bass']:setLooping(true)
sounds['terror']:play()
sounds['bass']:play()
self.scoretime =self.scoretime  + dt
if self.scoretime >=0.2 then
  self.score = self.score +1
  temp = temp +1
  if self.score %100 == 0 then
    sounds['score']:play()
  end
  if temp == 60 then
sounds['growl']:play()
temp =0
  end
  self.scoretime = 0
end
local time = math.random(1,2.5)
self.spawnTimer = self.spawnTimer + dt
if self.spawnTimer > time then
  ran = math.random(1,4)
table.insert(self.sprites,Sprite())
self.spawnTimer = 0
end

for key,sprite in pairs(self.sprites) do
sprite:update(dt)


end
--removing the sprites
for key,sprite in pairs(self.sprites) do
if sprite.x1 < -sprite.width then
  table.remove(self.sprites,key)
end
end

self.dino:update(dt)

for key,sprite in pairs(self.sprites) do
if self.dino:collision(sprite) then
sounds['explosion']:play()
sounds['hurt']:play()
sounds['terror']:stop()
  gStateMachine:change('score')
  gStateMachine:enterParams({score = self.score})
  sounds['laugh']:play()
end
end
end



function PlayState:render()
  for key,sprite in pairs(self.sprites) do
    sprite:render()
  end
self.dino:render()
self.dino:renderParticles()
love.graphics.setFont(TrexFont)
love.graphics.setColor(255,0,0)
love.graphics.printf('Score '..tostring(self.score), 8, 8,virtual_width, 'center')
love.graphics.setColor(255,255,255)
end
