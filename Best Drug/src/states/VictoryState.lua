
VictoryState = Class{__include = BaseState}

function VictoryState:enter(params)
    self.level = params.level
    self.score = params.score
    self.paddle = params.paddle
    self.health = params.health 
    self.ball = params.ball
    self.highScores = params.highScores
end

function VictoryState:update(dt)

    -- have the ball track the player
    self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8
 
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start',{
            highScores = self.highScores 
        })
    end
 
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then 
        gStateMachine:change('serve',{
            level = self.level + 1,
            bricks = LevelMaker.createMap(self.level + 1),
            paddle = self.paddle,
            health = self.health,
            score = self.score,
            highScores = self.highScores
        })
    end
end


function VictoryState:render()
    self.paddle:render()
    self.ball:render()


    renderHealth(self.health)
    renderScore(self.score)

    love.graphics.setFont(gFonts['CurlyFont'])
    love.graphics.printf('Level '.. tostring(self.level).."  is complete", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['DefaultFont'])
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("Press Enter to serve!", 0 , VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
    
end

function VictoryState:exit() end