
PlayState = Class{__include = BaseState}


function PlayState:enter(params)
    print('entered play state')
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.ball = params.ball
    self.level = params.level
    self.highScores = params.highScores

    -- give ball random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-80, -100)
end

function PlayState:init()
    self.pause = false
    self.powerUps = {}
end

function PlayState:update(dt) 

    --escape
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start',{
            highScores = self.highScores 
        })
    end
    
    --replay
    if love.keyboard.wasPressed('r') then
        gStateMachine:change('serve', {
            paddle = self.paddle,
            ball = self.ball,
            bricks = LevelMaker.createMap(self.level),
            level = self.level,
            health = 3,
            score = 0,
            highScores = self.highScores
        })
    end

    --pause mechanic
    if self.pause then 
        if love.keyboard.wasPressed('space') then
            self.pause = false  
        else
            return  
        end
    elseif love.keyboard.wasPressed('space') then
        self.pause = true      
        return
    end

    
    self.paddle:update(dt)
    self.ball:update(dt)

    for k, powerUp in pairs(self.powerUps) do
        powerUp:update(dt)
    end

    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end
   
    if self.ball:colides(self.paddle) then
        self.ball.y = self.paddle.y - 8
        self.ball.dy = -self.ball.dy

        --ball angle/speed after hitting the paddle 
        --if ball was coming from the right side and hit the paddle on an angle
        if self.ball.dx < 0 and self.ball.x < self.paddle.x + (self.paddle.width/2) then
            -- -50 is a starter value
            self.ball.dx = -50 + -(8*(self.paddle.x + self.paddle.width/2- self.ball.x ))

        elseif self.ball.dx > 0 and self.ball.x > self.paddle.x + (self.paddle.width/2) then
            self.ball.dx = 50 + (8* math.abs(self.paddle.x + self.paddle.width/2 - self.ball.x ))
        end
    end

    if self.ball.y >= VIRTUAL_HEIGHT then
        self.health = self.health - 1

        if self.health == 0 then
            gStateMachine:change('gameOver', {
                score = self.score,
                level = self.level,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                level = self.level,
                ball = self.ball,
                highScores = self.highScores
            })
        end
    end 

     -- detect collision across all bricks with the ball
    for k, brick in pairs(self.bricks) do

        -- only check collision if we're in play
        if brick.inPlay and self.ball:colides(brick) then

            -- add to score
            self.score = self.score + (brick.tier * 200 + brick.color * 25)

            -- trigger the brick's hit function, which removes it from play
            brick:hit()

            table.insert(self.powerUps, PowerUp(brick.x, brick.y))

            if self:checkVictory() then
                gStateMachine:change('victory',{
                    paddle = self.paddle,
                    health = 3,
                    score = self.score,
                    level = self.level,
                    ball = self.ball,
                    highScores = self.highScores
                })
            end

            print(#self.bricks)

            --if ball is moving right; left edge
            if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                --flip horizontal
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x -8

            --if ball is moving left; right edge
            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                --flip horizontal
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + 32
            
            --if ball is moving down; top edge
            elseif self.ball.y < brick.y then
                --flip vertecal
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - 8

            else 
                --flip vertecal
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y +16
            end

            -- slightly scale the y velocity to speed up the game
            self.ball.dy = self.ball.dy * 1.02
            
            
            -- only allow colliding with one brick, for corners
            break
        end
       
    end
    
    for k, powerUp in pairs(self.powerUps) do
        if powerUp.inPlay and powerUp:colides(self.paddle) then
            if powerUp.powerUp == 1 then
                self.health = self.health - 1
            end
            powerUp.inPlay = false
        end
    end

end

function PlayState:render() 

    for k, brick in pairs(self.bricks) do
        brick:render()
    end
    
    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    for k, powerUp in pairs(self.powerUps) do
        powerUp:render()
    end

    self.paddle:render()
    self.ball:render()

    renderHealth(self.health)
    renderScore(self.score)
    renderlevel(self.level)
    if self.pause then
        love.graphics.setFont(gFonts['CurlyFont'])
        love.graphics.setColor(1,0,0,1)
        love.graphics.printf("PAUSE", 0 , VIRTUAL_HEIGHT/2-20, VIRTUAL_WIDTH, 'center')
    end
end


function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
end

function PlayState:exit() end
