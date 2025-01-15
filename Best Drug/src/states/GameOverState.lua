GameOverState = Class{ __include = BaseState}

--these will be definde in the child class
function GameOverState:enter(params) 
    self.score = params.score
    self.level = params.level
    self.highScores = params.highScores
end

function GameOverState:update(dt) 


    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        -- see if score is higher than any in the high scores table
        local highScore = false

        -- keep track of what high score ours overwrites, if any
        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            gStateMachine:change('enterHighScore', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex
            }) 
        else 
            gStateMachine:change('start', {
                highScores = self.highScores
            }) 
        end

    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start',{
            highScores = self.highScores 
        })
    end

end

function GameOverState:render() 
    renderlevel(self.level)
    love.graphics.setFont(gFonts['CurlyFont'])
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['HighlightedFont'])
    love.graphics.printf('Final Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter!', 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')
end

function GameOverState:exit() end