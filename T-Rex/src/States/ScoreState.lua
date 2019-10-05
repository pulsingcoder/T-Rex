--[[
A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Sprite.
    ]]
    ScoreState = Class{_includes = Base}
    --[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(Params)
self.score = Params.score
end


function ScoreState:update(dt)
if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
  gStateMachine:change('title')
end
end

function ScoreState:render()
love.graphics.setFont(TrexFont)
love.graphics.setColor(255,0,0)
love.graphics.printf('Oof! You Loose!', 0, 64,virtual_width,'center')
love.graphics.setColor(0,0,0)
love.graphics.setFont(mediumFont)
love.graphics.printf('Score: '..tostring(self.score), 0, 100, virtual_width, 'center')
love.graphics.printf('Press Enter to Play Again', 0, 160, virtual_width, 'center')

end
