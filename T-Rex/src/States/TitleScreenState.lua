--[[
The TitleScreenState is the starting screen of the game, shown on startup. It should
display "Press Enter" and also our highest score.
]]
TitleScreenState = Class{_includes = Base}




function TitleScreenState:update(dt)
  sounds['dino']:setLooping(true)
  sounds['dino']:play()

if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
gStateMachine:change('play')
sounds['dino']:stop()
end
end


function TitleScreenState:render()
love.graphics.setFont(ScaryFont)
love.graphics.setColor(250, 0, 0)
love.graphics.printf('T-Rex', 0, 64,virtual_width, 'center')
love.graphics.setFont(murderFont)


love.graphics.printf('Press Enter', 0, 100, virtual_width, 'center')
love.graphics.setColor(255,255,255)
end
