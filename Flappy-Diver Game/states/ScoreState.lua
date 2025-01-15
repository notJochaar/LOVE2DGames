ScoreState = Class{__includes = BaseState}


function ScoreState:update(dt) 
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        print("working")
        scrolling = true
        gStateMachine:change('count')
    end 
end

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:render() 
    love.graphics.setFont(CurlyFont)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf('You Dead', 0, 25, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(BigFont)
    love.graphics.printf('Score '.. tostring(self.score) , 0, VIRTUAL_HEIGHT/2 , VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(SmallFont)
    love.graphics.print(':', VIRTUAL_WIDTH/2+25,  VIRTUAL_HEIGHT/2+12)

    love.graphics.setFont(SmallFont)
    love.graphics.printf('Press Enter To Restart', 0, VIRTUAL_HEIGHT/2+25, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(DefaultFont)
    love.graphics.printf('V1.0', 0, VIRTUAL_HEIGHT-20, VIRTUAL_WIDTH, 'right')
    --love.graphics.setColor(1,1,1,.3)
    --love.graphics.printf('By Saeed Alsuwaidi', 0, 0, VIRTUAL_WIDTH, 'center')
end

