HighScoreState = Class{ __include = BaseState }

--these will be definde in the child class
function HighScoreState:init()
   
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start',{
            highScores = self.highScores 
        })
    end
end


function HighScoreState:enter(params)
    self.highScores = params.highScores
end
function HighScoreState:exit() end


function HighScoreState:render() 

    love.graphics.setFont(gFonts['CurlyFont'])
    love.graphics.printf('High Scores', 0, 5, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['HighlightedFont'])

    love.graphics.setColor(1,0,0,1)
    love.graphics.printf('Rank', 50 , 50, VIRTUAL_WIDTH-100, 'left')
    love.graphics.printf('Name', 50 , 50, VIRTUAL_WIDTH-100, 'center')
    love.graphics.printf('Score', 50 , 50, VIRTUAL_WIDTH-100,'right')
    love.graphics.setColor(1,1,1,1)
    
    y = 70

    for i = 1, 10, 1 do

        if i == 1 then 
            love.graphics.setColor(1,0.9,0.2,1) -- gold
        elseif i == 2 then
            love.graphics.setColor(0.7,0.7,0.7,1) -- silver
        elseif i == 3 then
            love.graphics.setColor(1,0.5,0.3,1) --bronze
        else
            love.graphics.setColor(1,1,1,1)
        end

        love.graphics.printf(tostring(i), 50 , y, VIRTUAL_WIDTH-100, 'left')

        love.graphics.printf(tostring(self.highScores[i].name), 50 , y, VIRTUAL_WIDTH-100, 'center')

        love.graphics.printf(tostring(self.highScores[i].score), 50 , y, VIRTUAL_WIDTH-100, 'right')

        y = y + 18 
    end
    
end