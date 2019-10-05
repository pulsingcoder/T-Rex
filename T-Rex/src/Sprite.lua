Sprite = Class()
sprite_Scroll = -220

function Sprite:init()
if ran ==1 then
self.image = love.graphics.newImage('graphics/Sprite1.png')
self.width = self.image:getWidth()
self.height = self.image:getHeight()
self.x1 = virtual_width
self.y1 = virtual_height - self.height-10
elseif ran == 2 then
  self.image = love.graphics.newImage('graphics/Sprite2.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.x1 = virtual_width
  self.y1 = virtual_height - self.height-10
elseif ran == 3 then
  self.image = love.graphics.newImage('graphics/dinosprite6.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.x1 = virtual_width
  self.y1 = virtual_height - self.height-10
elseif ran ==4 then
  self.image = love.graphics.newImage('graphics/dinosprite10.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.x1 = virtual_width
  self.y1 = virtual_height - self.height-10
end
end



function Sprite:update(dt)
self.x1 = self.x1 + sprite_Scroll*dt
end



function Sprite:render()
love.graphics.draw(self.image, self.x1, self.y1)

end
