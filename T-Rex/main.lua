-- T-Rex Game........ 
-- Sounds credit https://freesound.org
push = require "push"
Class = require "lib/class"
require "src/Dino"
require "src/Sprite"
require "src/StateMachine"
require "src/States/Base"
require "src/States/ScoreState"
require "src/States/PlayState"
require "src/Animation"

require "src/States/TitleScreenState"
window_width = 1280
window_height = 720
virtual_width = 512
virtual_height = 288
local background = love.graphics.newImage('graphics/back2.png')
 particle = love.graphics.newImage('graphics/particle.png')
local background_scroll = 0
local background_scroll_speed = 30
local background_looping_point = 413
local ground = love.graphics.newImage('graphics/ground1.png')
local ground_scroll = 0
local ground_scroll_speed = 60
spawn = true



function love.load()
  -- used to filter the pixel such that no bluring is there
 love.graphics.setDefaultFilter('nearest','nearest')
 -- used to provide different random no. each time of execution
 math.randomseed(os.time())
 love.window.setTitle('T-REX')
 TrexFont = love.graphics.newFont('fonts/flappy.ttf',28)
 mediumFont = love.graphics.newFont('fonts/font.ttf',14)
smallFont = love.graphics.newFont('fonts/font.ttf', 8)
ScaryFont = love.graphics.newFont('fonts/scary.ttf', 45)
murderFont = love.graphics.newFont('fonts/murder.ttf', 25)
 love.graphics.setFont(TrexFont)
 sounds = {
  -- ['jump'] = love.audio.newSource('FSo.wav','static'),
  ['growl'] = love.audio.newSource('FSounds/growl.wav','static'),
   ['hurt'] = love.audio.newSource('FSounds/fhurt.wav','static'),
   ['score'] = love.audio.newSource('FSounds/fscore.wav','static'),
   ['explosion'] = love.audio.newSource('FSounds/fexplotion.wav','static'),
   ['pause'] = love.audio.newSource('FSounds/fPause.wav','static'),
   ['dino'] = love.audio.newSource('FSounds/dino.wav', 'static'),
   ['terror'] = love.audio.newSource('FSounds/terror.wav', 'static'),
   ['laugh'] =love.audio.newSource('FSounds/laugh.wav', 'static'),
   ['bass'] = love.audio.newSource('FSounds/bass.mp3', 'static')
  }

 --setup the virtual screen for game
 push:setupScreen(virtual_width,virtual_height,window_width,window_height,{
   fullscreen = false,
   resizable =  true,
   vsync = true
 })
 -- initialize state machine with all state-returning functions
 gStateMachine = StateMachine{
   ['title'] = function() return TitleScreenState() end ,
   ['play'] = function() return PlayState() end,
   ['score'] = function() return ScoreState() end
 }
 gStateMachine:change('title')
 -- used to store all keys that are pressed during the game play state
love.keyboard.keysPressed = {}
end






function love.resize(w,h)
  push:resize(w,h)
end






 function love.update(dt)
   --if spawn is true than continue scrolling
   if spawn then
   background_scroll = (background_scroll + background_scroll_speed*dt)%background_looping_point
ground_scroll = (ground_scroll + ground_scroll_speed*dt)%virtual_width
gStateMachine:update(dt)
--making table empty by every frame
love.keyboard.keysPressed = {}

end
end





function love.keypressed(key)
love.keyboard.keysPressed[key] = true
if key == 'escape' then
  love.event.quit()
end
end





function love.keyboard.wasPressed(key)
if love.keyboard.keysPressed[key] == true then
  return true
else
  return false
end
end







function love.draw()
  push:start()
love.graphics.draw(background, -background_scroll, 0)
gStateMachine:render()
love.graphics.draw(ground, -ground_scroll, virtual_height-16)
  push:finish()
end
