Dino = Class{}
gravity = 15
count = 0
local temp =0
-- some of the colors in our palette (to be used with particle systems)
paletteColors = {
    -- blue
    [1] = {
        ['r'] = 0,
        ['g'] = 0,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 0,
        ['g'] = 200,
        ['b'] = 0
    },
    -- red
    [3] = {
        ['r'] = 200,
        ['g'] = 0,
        ['b'] = 0
    },
    -- purple
    [4] = {
        ['r'] = 20,
        ['g'] = 0,
        ['b'] = 186
    },
    -- gold
    [5] = {
        ['r'] = 251,
        ['g'] = 242,
        ['b'] = 10
    }
}



function Dino:init()
self.image = love.graphics.newImage('graphics/dino3.png')
movingAnimation = Animation{
['frames'] = {1,2},
['interval'] = 0.1

}
jumpAnimation = Animation{
  ['frames'] = {2},
  ['interval'] = 1

}
currentAnimation = movingAnimation
sprite = love.graphics.newImage("graphics/spritedino.png")
quad = love.graphics.newQuad
dinoSprite = {
quad(0,0,37,39,sprite:getDimensions()),
quad(0,46,37,39,sprite:getDimensions())
}

self.width  = self.image:getWidth()
self.height = self.image:getHeight()
self.x = 25
self.y = virtual_height-self.height-13
self.dy =0
self.psystem = love.graphics.newParticleSystem(particle, 64)
self.psystem:setParticleLifetime(0.1,0.2)
self.psystem:setLinearAcceleration(15,0,25,0)
self.psystem:setEmissionArea('normal',10,10)
end




function Dino:update(dt)
  --continuous jumping over the screen
  self.psystem:update(dt)
  --[[
if self.y >= virtual_height - self.height - 13 then
  self.dy = -2
  count =0
end--]]
currentAnimation:update(dt)
self.dy = self.dy + gravity*dt
if love.keyboard.wasPressed('up')  then
  currentAnimation = jumpAnimation
temp = temp +1
  if temp ==5 then
  random =  math.random(1,2)
      sounds['growl']:play()
temp = 0
end
  self.dy = -6
  count = count + 1
end
self.y = self.y + self.dy
if (self.y > virtual_height - self.height - 13) then
self.dy = 0
currentAnimation = movingAnimation
self.y = virtual_height - self.height - 13

end
if love.keyboard.wasPressed('g') then
  self.psystem:setColors(
  paletteColors[3].r,
  paletteColors[3].g,
  paletteColors[3].b,
  255,
  paletteColors[2].r,
  paletteColors[2].g,
  paletteColors[2].b,
  255,
  paletteColors[1].r,
  paletteColors[1].g,
  paletteColors[1].b,
  255

)
self.psystem:setSizeVariation(1)
self.psystem:emit(35)

end
end







function Dino:collision(sprite)
if self.x + self.width -15 >= sprite.x1  and self.x +11 <= sprite.x1 + sprite.width then

if self.y + self.height -15 >= sprite.y1 and self.y +10 <= sprite.y1 + sprite.height then
  return true
end
end
return false
end


function Dino:renderParticles()
love.graphics.draw(self.psystem, self.x+45, self.y+10)

end



function Dino:render()
  love.graphics.setColor(0.5, 0.9,0.3 , 255)
love.graphics.draw(sprite,dinoSprite[currentAnimation:getCurrentFrame()], self.x, self.y)
end
