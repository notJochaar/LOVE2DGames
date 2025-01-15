ServeState = Class{__include = BaseState}

function ServeState:enter(params) 
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.level = params.level
    self.highScores = params.highScores

    self.ball = Ball()
    self.ball.skin = math.random(7)
end

function ServeState:update(dt) 

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
        gStateMachine:change('play', {
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            ball = self.ball,
            level = self.level,
            highScores = self.highScores
        })
    end
end

function ServeState:render() 
    self.paddle:render()
    self.ball:render()


    renderHealth(self.health)
    renderScore(self.score)
    renderlevel(self.level)

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    love.graphics.setFont(gFonts['CurlyFont'])
    love.graphics.printf('Level'..tostring(self.level), 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['DefaultFont'])
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("Press Enter to serve!", 0 , VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
    

end


function ServeState:exit() end