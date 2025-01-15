PaddleSelectState = Class{__include = BaseState}

--these will be definde in the child class
function PaddleSelectState:init() 
    self.currentPaddle = 1
end

function PaddleSelectState:enter(params)
    self.highScores = params.highScores
end

function PaddleSelectState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start',{
            highScores = self.highScores 
        })
    end

    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
        if self.currentPaddle == 1 then
           --do nothing
        else
            self.currentPaddle = self.currentPaddle - 1
        end
    elseif love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
        if self.currentPaddle == 4 then
            --do nothin
        else
            self.currentPaddle = self.currentPaddle + 1
        end
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gStateMachine:change('serve', {
            paddle = Paddle(self.currentPaddle),
            bricks = LevelMaker.createMap(1),
            health = 3,
            score = 0,
            highScores = self.highScores,
            level = 1
        })
    end
end

function PaddleSelectState:render()
    love.graphics.setFont(gFonts['CurlyFont'])
    love.graphics.printf('Select your paddle', 0, 15, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['HighlightedFont'])

    love.graphics.printf('(Press Enter to Select)', 50 , 50, VIRTUAL_WIDTH-100, 'center')

    if self.currentPaddle == 1 then
        -- tint; give it a dark gray with half opacity
        love.graphics.setColor(40/255, 40/255, 40/255, 128/255)
    end

    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][1], VIRTUAL_WIDTH / 4 - 24,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3)

     -- reset drawing color to full white for proper rendering
     love.graphics.setColor(1, 1, 1, 1)


     -- right arrow; should render normally if we're less than 4, else
    -- in a shadowy form to let us know we're as far right as we can go
    if self.currentPaddle == 4 then
        -- tint; give it a dark gray with half opacity
        love.graphics.setColor(40/255, 40/255, 40/255, 128/255)
    end

    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][2], VIRTUAL_WIDTH - VIRTUAL_WIDTH / 4,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3)


    -- reset drawing color to full white for proper rendering
    love.graphics.setColor(1, 1, 1, 1)

    -- draw the paddle itself, based on which we have selected
    love.graphics.draw(gTextures['main'], gFrames['paddles'][2 + 4 * (self.currentPaddle - 1)],
        VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3)

end

function PaddleSelectState:exit() end