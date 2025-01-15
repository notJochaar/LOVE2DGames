push = require 'push'
Class = require 'class'

require 'Submarine'
require 'Rock'

--this is a class for a Pair of rocks
require 'RockPair'

--this creates a termenal to show the 
require "conf"


--Import Status classes 
--the State Machine controles all the states of our game
require 'StateMachine' 
require 'states/BaseState'
require 'states/CountDownState'
require 'states/GameState'
require 'states/ScoreState'
require 'states/SplashScreenState'

--window size
WINDOW_WIDTH = 1440
WINDOW_HEIGHT = 900

--game window size
VIRTUAL_WIDTH  = 400
VIRTUAL_HEIGHT = 180

--the parallex effect 
--its an illution of movement gives a feeling of depth
--we want to apply it on the background
--we will make 3 layers of the image ('forground','midground','background')
--each image will move at a different rate so it gives a feeling of depth
 
local background_img = love.graphics.newImage('Assets/Background.png')
local backgroundScroll = 0

local middleground_img = love.graphics.newImage('Assets/MiddleGround.png')
local middlegroundScroll = 0

 foreground_img = love.graphics.newImage('Assets/Foreground.png')
 foregroundScroll = 0

local BACKGROUND_SCROLL_SPEED = 5
local MIDDLEGROUND_SCROLL_SPEED = 30
local FOREGROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 400

local rock_img = love.graphics.newImage('Assets/rock.png')

--this variable is to disable scrolling on collition 
local scrolling = true

function love.load()

    math.randomseed(os.time())

    love.graphics.setDefaultFilter("nearest", "nearest")

    love.window.setTitle('Flappy Diver')

    --importing fonts 
    SmallFont = love.graphics.newFont('fonts/dogica/TTF/dogicapixel.ttf', 8)
    DefaultFont = love.graphics.newFont('fonts/pixel_operator/PixelOperator.ttf', 16)
    CurlyFont = love.graphics.newFont('fonts/daydream_3/Daydream.ttf', 21)
    BigFont = love.graphics.newFont('fonts/8_bit_arcade/8-bit Arcade In.ttf', 32)
    Hugefont = love.graphics.newFont('fonts/crang/Crang.ttf', 50)
    
    push:setupScreen( VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    audio = {
        ['soundTrack'] = love.audio.newSource('audio/15 Underground Theme (Hurry).mp3', 'static'),
        ['jump'] = love.audio.newSource('audio/jump.mp3', 'static'),
        ['death'] = love.audio.newSource('audio/death.mp3', 'static'),
        ['fall'] = love.audio.newSource('audio/fall.mp3', 'static'),
        ['ambiente'] = love.audio.newSource('audio/underwater-ambiencewav.mp3', 'static'),
        ['start'] = love.audio.newSource('audio/sonar-start.mp3', 'static')
    }

    audio['soundTrack']:setLooping(true)
    audio['soundTrack']:play()

    audio['ambiente']:setLooping(true)
    audio['ambiente']:play()

    --'g' is a naming convention for a global variabal 
    --this state machine will store all the states in this table
    --so it can be accessed from anywhere 
    gStateMachine = StateMachine {
        ['title'] = function() return SplashScreenState() end,
        ['count'] = function() return CountDownState() end,
        ['play'] = function() return GameState() end,
        ['score'] = function() return ScoreState() end
    }

    --this function changes the state to title state
    --scrolling = false
    gStateMachine:change('title')


    --create a table to store the keys pressed and thier value
    love.keyboard.keypressed = {}
end

function love.keypressed(key)

    --store the key name and its value to the table
    love.keyboard.keypressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    --this will return the value of any key that is given
    return love.keyboard.keypressed[key]
end

function love.update(dt)

    if scrolling then

        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED* dt)
        % BACKGROUND_LOOPING_POINT

        middlegroundScroll = (middlegroundScroll + MIDDLEGROUND_SCROLL_SPEED* dt)
        % BACKGROUND_LOOPING_POINT

        foregroundScroll = (foregroundScroll + FOREGROUND_SCROLL_SPEED* dt)
        % BACKGROUND_LOOPING_POINT


        --this update will run all the logic of the game in the state machine class
        gStateMachine:update(dt)

        
    end

    love.keyboard.keypressed = {}

end

function love.draw()
    push:apply('start')

    love.graphics.clear(0.1,0.2,0.3, 1)
    
    

    --this method draws any drawable on the screen 
    --in this case were using an image 
    --an image is a drawable
    love.graphics.draw(background_img, -backgroundScroll,0)
    love.graphics.draw(background_img, 400-backgroundScroll,0)

    --math.floor prevent dicemal numbers which produce blur
    love.graphics.draw(middleground_img, math.floor(-middlegroundScroll),16)
    love.graphics.draw(middleground_img,  math.floor(400-middlegroundScroll),16)

 
    gStateMachine:render()

    love.graphics.draw(foreground_img, math.floor(-foregroundScroll),0)
    love.graphics.draw(foreground_img, math.floor(400-foregroundScroll),0)
    

    push:apply('end')
end

function love.resize(w,h)
   push:resize(w,h) 
end