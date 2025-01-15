EnterHighScoreState = Class{ __include = BaseState}

--a table to store our name characters
local chars = {
    -- 65: This is the ASCII value for the uppercase letter A
    [1] = 65,
    [2] = 65,
    [3] = 65
}

local highlightedChar = 1
--these will be definde in the child class
function EnterHighScoreState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
    self.scoreIndex = params.scoreIndex
end

function EnterHighScoreState:update(dt)

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start',{
            highScores = self.highScores 
        })
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        --update scores table
        local name = string.char(chars[1])..string.char(chars[2])..string.char(chars[3])

        -- go backwards through high scores table till this score, shifting scores
        for i = 10, self.scoreIndex, -1 do
            --increase all the scores rank above the new score
            self.highScores[i + 1] = {
                name = self.highScores[i].name,
                score = self.highScores[i].score
            }
        end

        --store the new score in the table
        self.highScores[self.scoreIndex].name = name
        self.highScores[self.scoreIndex].score = self.score
        
        -- write scores to file
        local scoresStr = ''

        for i = 1, 10 do
            scoresStr = scoresStr .. self.highScores[i].name .. '\n'
            scoresStr = scoresStr .. tostring(self.highScores[i].score) .. '\n'
        end

        love.filesystem.write('breakout.lst', scoresStr)

        gStateMachine:change('highScore',{
            highScores = self.highScores
        })

    end

    --scroll left and right
    if (love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d')) and highlightedChar < 3 then
        highlightedChar = highlightedChar + 1

    elseif (love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a')) and highlightedChar > 1 then
        highlightedChar = highlightedChar - 1
    end

    --scroll through characters
    if (love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w')) then
        chars[highlightedChar] = chars[highlightedChar] + 1
        if chars[highlightedChar] > 90 then
            chars[highlightedChar] = 65
        end

    elseif (love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s')) then
        chars[highlightedChar] = chars[highlightedChar] - 1
        if chars[highlightedChar] < 65 then
            chars[highlightedChar] = 90
        end
    end

    print(highlightedChar)
end

function EnterHighScoreState:render()

    love.graphics.setFont(gFonts['HighlightedFont'])

    love.graphics.printf('Final Score: ' .. tostring(self.score), 0, 45, VIRTUAL_WIDTH, 'center')
    
    love.graphics.printf('Press Enter to Save!', 0, VIRTUAL_HEIGHT - 20 , VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['CurlyFont'])

    if highlightedChar == 1 then
        love.graphics.setColor(1, 0, 0, 1)
    end
    love.graphics.print(string.char(chars[1]), VIRTUAL_WIDTH / 2 - 35, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 2 then
        love.graphics.setColor(1, 0, 0, 1)
    end
    love.graphics.print(string.char(chars[2]), VIRTUAL_WIDTH / 2 - 8, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 3 then
        love.graphics.setColor(1, 0, 0, 1)
    end
    love.graphics.print(string.char(chars[3]), VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.printf('High Score Name', 0, 10, VIRTUAL_WIDTH, 'center')

end

function EnterHighScoreState:exit() end