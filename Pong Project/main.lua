
--this is how to import a library
push = require 'push'


--importing 'class' library
Class = require 'class'

--our paddle class
require 'Paddle'
--our ball class
require 'Ball'

-- Actual window size (can be anything)
WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 750

-- Virtual resolution (the size you "pretend" your game is)
VIRTUAL_WIDTH = 470
VIRTUAL_HEIGHT = 300

--Paddle Speed
PADDLE_SPEED = 200


--load only once when the game starts
function love.load()

    --this applies a filter to our graphics (a blur to make things smooth)
    --but we will change the fiter because our graphics is pixels ,so we dont need a blur. 
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --this sets the title of the window 'top left corner'
    love.window.setTitle('Gong')

    --import minecraft text font form the file
    font = love.graphics.newFont("font/minecraft/Minecraft.ttf", 16)
    bigfont = love.graphics.newFont("font/upheaval/upheavtt.ttf", 20)
    smallfont=love.graphics.newFont("font/upheaval/upheavtt.ttf", 10)

    --this is a table, similer to JSON format
    audio = {
        ['paddle_hit'] = love.audio.newSource('audio/Paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('audio/Score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('audio/wall_hit.wav', 'static')
    }

    --this random sets a random seed produced by the current time because each second has a different number
    --this is important because it randomize the resultes of the math.random(0,10) if u didnt do this it will always pick the same number
    math.randomseed(os.time())
    
    --set text font
    love.graphics.setFont(font)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    
    --initalize our player paddles
    player1 = Paddle(10, 30, 10, 50)
    player2 = Paddle(VIRTUAL_WIDTH - 20, VIRTUAL_HEIGHT - 100 ,10,50)
    
    player1Score = 0
    player2Score = 0

    --initalize our ball
    ball = Ball(VIRTUAL_WIDTH/2-5, VIRTUAL_HEIGHT/2-5, 10,10)

    -- game state will be used to specify which state the game is in ('menu', 'loading screed', etc..)
    gameState = 'start'

    textcontent = ''

end


--keyboard handling, called by LOVE2D each frame. 
function love.keypressed(key)
    --check if button is pressed
    if key == 'escape' then
        -- this function teminate the application
        love.event.quit()
    
    --enter and return key is the same thing in modern keyboards
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        elseif gameState == 'pause' then
            gameState = 'play'
        else 
            gameState = 'pause'
            textcontent = 'PAUSE'
            player1.dy = 0
            player2.dy = 0
        end
    end
    
end


function love.update(dt)

    --player 1 movement
    if gameState == 'play' then


        --ball movement logic
        --detects if ball collide with a player then reverse the direction of the ball
        --and incerece the speed by 10%
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.10
            ball.x = player1.x + 10
            
            audio['paddle_hit']:play()

            --keep the direction but with slight random change in angle
            if ball.dy < 0 then
                ball.dy = -math.random(10,200)
            else 
                ball.dy = math.random(10,200)
            end
        end
    
        if ball:collides(player2)then
            ball.dx = -ball.dx * 1.10
            ball.x = player2.x - 10

            audio['paddle_hit']:play()

            --keep the direction but with slight random change in angle
            if ball.dy < 0 then
                ball.dy = -math.random(10,200)
            else 
                ball.dy = math.random(10,200)
            end
        end

        --if the ball touched the window then reverse the delta y
        if ball.y >= VIRTUAL_HEIGHT - ball.height then
            ball.dy = -ball.dy 
            ball.y = ball.y- 5

            audio['wall_hit']:play()
        elseif ball.y <= 0 then
            ball.dy = -ball.dy 
            ball.y = ball.y + 5

            audio['wall_hit']:play()
        end

        --this checks if the player in border if yes then move
        if love.keyboard.isDown('w') then 
            player1.dy = -PADDLE_SPEED
            
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED

        else
            player1.dy = 0
        end

        -- --player 2 movement
        if love.keyboard.isDown('up') then
             player2.dy = -PADDLE_SPEED
            elseif love.keyboard.isDown('down') then
             player2.dy = PADDLE_SPEED
         else
             player2.dy = 0
         end
        
        -- --AI movement
        -- if player2.y + player2.width/2 > ball.y + ball.width/2 then
        --     player2.dy = -PADDLE_SPEED/1.3
        -- else  
        --     player2.dy = PADDLE_SPEED/1.3
        -- end

       

       

        if ball.x >= VIRTUAL_WIDTH then
            player1Score = player1Score + 1
            audio['score']:play()
            ball:reset()
        end
    
        if ball.x <= 0 then
            player2Score = player2Score + 1
            audio['score']:play()
            ball:reset()
        end
    
        --game logic
        if player1Score == 2 then
            gameState = 'start'
            textcontent = 'Player Won!!'
            player1Score = 0
            player2Score = 0
        elseif  player2Score == 2 then
            gameState = 'start'
            textcontent = 'NPC Won!!'
            player1Score = 0
            player2Score = 0
        end

        player1:update(dt)
        player2:update(dt)
        ball:update(dt)
    end


    
end


function love.draw()
    --start rendering with push at virtual res
    push:apply('start')

    --clear the screen with a specific color
    love.graphics.clear(love.math.colorFromBytes(255, 76, 48))

    love.graphics.setColor(0.047,0.055,0.063, 0.6)

    -- Draw a dashed line with 10-pixel dashes and 5-pixel gaps
    drawDashedLine(VIRTUAL_WIDTH/2, 0, VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT, 20 , 30)
    
    love.graphics.rectangle('line',VIRTUAL_WIDTH/2-50, VIRTUAL_HEIGHT/2-50, 100,100)

    love.graphics.rectangle('fill',VIRTUAL_WIDTH/2-15, VIRTUAL_HEIGHT/2-15, 30,30)

    -- Set text color 
    love.graphics.setColor(love.math.colorFromBytes(74, 21, 173))

    --setting the scoreing text 
    love.graphics.setFont(bigfont)
    
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2-50, VIRTUAL_HEIGHT/2-70)

    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2+40, VIRTUAL_HEIGHT/2-70)

    love.graphics.setFont(bigfont)
    love.graphics.printf(
        'My first game, PONG!!', --our text
        0,                      --we setl this to 0 because we will use the center
        20,                     --top of the screen
        VIRTUAL_WIDTH,           --number of pixels to center within 
        'center'                --this is the alignment, can also be 'left' or 'right'
    )     

    if gameState == 'start' then
        love.graphics.setFont(bigfont)
        --write pause in the middle
        love.graphics.printf('Press Enter to Start', 0, VIRTUAL_HEIGHT/2 + 30 , VIRTUAL_WIDTH, 'center')
        love.graphics.printf(textcontent, 0, VIRTUAL_HEIGHT/2 + 10 , VIRTUAL_WIDTH, 'center')
    elseif gameState == 'pause' then
        love.graphics.setFont(bigfont)
        --write pause in the middle
        love.graphics.printf(textcontent, 0, VIRTUAL_HEIGHT/2 +20 , VIRTUAL_WIDTH, 'center')
    end

    --show the fps on top right corner
    displayFPS()

    love.graphics.setColor(0.047,0.055,0.063)

    --left player
    player1:render(74, 21, 173)
    

    --right player
    player2:render(74, 21, 173)
    

    --the ball
    ball:render(74, 21, 173)

    --end rendering 
    push:apply('end')
end


function drawDashedLine(x1, y1, x2, y2, dashLength, gapLength)
    -- Calculate the distance and direction of the line
    local dx = x2 - x1
    local dy = y2 - y1
    local lineLength = math.sqrt(dx^2 + dy^2)

    -- Normalize direction
    local nx = dx / lineLength
    local ny = dy / lineLength

    -- Variables for drawing
    local currentLength = 0

    -- Draw dashes along the line
    while currentLength < lineLength do
        -- Calculate start and end points for the dash
        local startX = x1 + nx * currentLength
        local startY = y1 + ny * currentLength
        local endLength = math.min(currentLength + dashLength, lineLength)
        local endX = x1 + nx * endLength
        local endY = y1 + ny * endLength

        -- Draw the dash

        love.graphics.line(startX, startY, endX, endY)

        -- Move to the next dash position (gap + dash)
        currentLength = currentLength + dashLength + gapLength
    end
end

function displayFPS()
    --show the fps on top right corner
    love.graphics.setColor(0,0,0,1)
    love.graphics.setFont(smallfont)
    love.graphics.printf('FPS:'..tostring(love.timer.getFPS()), 0, 10 , VIRTUAL_WIDTH, 'right')
end

--called by love whenever we resize the screen, it changes the window size
--but it will maintain the virutal resulotion
function love.resize(w,h)
    push:resize(w,h)
end