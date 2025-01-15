--organaize our files into--
--src
    --constants    *will hold all the constatnts values
    --Dependencies *Will import all the files we need to the project
    --//other code files and folders
--lib 
    --//all the libraries were using
--sound
    --//all sounds
--graphic
    --//all graphics
--font
    --//all fonts

--we import the Dependencies file, that imports all files we need
require 'src/Dependencies'

function love.load()

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Bricks Paddle')

    --global variables
    gFonts = {
        --importing fonts 
        ['SmallFont'] = love.graphics.newFont('fonts/dogica/TTF/dogicapixel.ttf', 8),
        ['DefaultFont'] = love.graphics.newFont('fonts/pixel_operator/PixelOperator8.ttf', 8),
        ['HighlightedFont'] = love.graphics.newFont('fonts/pixel_operator/PixelOperator8-Bold.ttf', 8),
        ['CurlyFont'] = love.graphics.newFont('fonts/daydream_3/Daydream.ttf', 21),
        ['BigFont'] = love.graphics.newFont('fonts/8_bit_arcade/8-bit Arcade In.ttf', 32),
        ['Hugefont'] = love.graphics.newFont('fonts/crang/Crang.ttf', 50)
    }

    gTextures = {
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
    }

    --this table is for grouped quads to only show part of the texture
    gFrames = {
        ['paddles'] = GenerateQuadsPaddle(gTextures['main']),
        ['balls'] = GenerateQuadsBalls(gTextures['main']),
        ['bricks'] = GenerateQuadsBricks(gTextures['main']),
        ['hearts'] = GenerateQuads(gTextures['hearts'],10, 9),
        ['arrows'] = GenerateQuads(gTextures['arrows'],24, 24),
        ['powerups'] = GenerateQuadsPowerUps(gTextures['main'])
    }  

    push:setupScreen( VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    --create a global variable of StateMachine table that have a 'start' key 
    --the value will be a 
    gStateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['serve'] = function() return ServeState() end,
        ['play'] = function() return PlayState() end,
        ['gameOver'] = function() return GameOverState() end,
        ['victory'] = function() return VictoryState() end,
        ['highScore'] = function() return HighScoreState() end,
        ['enterHighScore'] = function() return EnterHighScoreState() end,
        ['paddleSelect'] = function() return PaddleSelectState() end
    }

    --gStateMachine:change('enterHighScore')

    gStateMachine:change('start',{
        highScores = loadHighScores()
    })

    --create a table to store the keys pressed and thier value
    love.keyboard.keypressed = {}
end


function love.update(dt)

    gStateMachine:update(dt)
    --empty the table
    love.keyboard.keypressed = {}
end

function love.draw()
    push:apply('start')

    local BGWidth = gTextures['background']:getWidth()
    local BGHight = gTextures['background']:getHeight()

    love.graphics.clear(.2,.5,1,1)
    --love.graphics.setColor(1, .4, .2, 1)
    love.graphics.draw(gTextures['background'], 
        --X and Y coordinates
        0,0,
        --0 rotation
        0, 
        --scale x and y
        VIRTUAL_WIDTH / (BGWidth -1) , VIRTUAL_HEIGHT / (BGHight-1))
    love.graphics.setColor(1, 1, 1, 1)

    gStateMachine:render()

    displayFPS()

    push:apply('end')
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(gFonts['SmallFont'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end

function love.keypressed(key)

    --store the key name and its value to the table
    love.keyboard.keypressed[key] = true
end

function love.keyboard.wasPressed(key)
    --this will return the value of any key that is given
    return love.keyboard.keypressed[key] 

end

function love.resize(w,h)
    push:resize(w,h)
end

function renderHealth(health)
    -- start of our health rendering
    local healthX = VIRTUAL_WIDTH - 35
    
    -- render health left
    for i = 1, health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][1], healthX, 4)
        healthX = healthX + 11
    end

    -- render missing health
    for i = 1, 3 - health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][2], healthX, 4)
        healthX = healthX + 11
    end
end

function renderScore(score)
    love.graphics.setFont(gFonts['SmallFont'])
    love.graphics.print('Score:', 75, VIRTUAL_HEIGHT - 15)
    love.graphics.printf(tostring(score), 115, VIRTUAL_HEIGHT - 15, VIRTUAL_WIDTH - 50, 'left')
end

function renderlevel(level)
    love.graphics.setFont(gFonts['SmallFont'])
    love.graphics.print('Level', 5, VIRTUAL_HEIGHT - 15)
    love.graphics.printf(tostring(level), 40, VIRTUAL_HEIGHT - 15, VIRTUAL_WIDTH - 50, 'left')
end


function loadHighScores()
    --sets the *write* directory for your game
    love.filesystem.setIdentity('breakout')

    --if the file doesnt exist, initialize with some data
    --Gets information about the specified file or directory
    if not love.filesystem.getInfo('breakout.lst') then
        local scores = ''
        for i = 10, 1, -1 do 
            scores = scores .. 'CT5\n'
            scores = scores .. tostring(i * 100) .. '\n'
        end

        --Write data to a file.
        love.filesystem.write('breakout.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

     -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('breakout.lst') do
        print(line)
        if name then
            --string.sub gets a part of the given stirng from position 1 to 3
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter +1
        end

        -- flip the name flag
        --we will get the name in the first loop/line the next line is the score
        name = not name
    end

    return scores
end

function loadLevel()
    love.filesystem.setIdentity('level')
end