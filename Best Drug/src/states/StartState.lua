
StartState = Class{__include = BaseState}

--this is to track which option is highlighted in the main menu
local highlighted = 1

function StartState:init() end

function StartState:update(dt) 
    
    --scroll through menu
    if (love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w')) then
        highlighted = highlighted - 1
        if highlighted > 3 then
            highlighted = 1
        end

    elseif (love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s')) then
        highlighted = highlighted + 1
        if highlighted < 2 then
            highlighted = 4
        end
    end


    if highlighted == 1 and love.keyboard.wasPressed('enter') or (highlighted == 1 and love.keyboard.wasPressed('return')) then
        print('go to serve')
        gStateMachine:change('serve', {
            paddle = Paddle(1),
            bricks = LevelMaker.createMap(1),
            health = 3,
            score = 0,
            level = 1,
            highScores = self.highScores
        })
    end

    if highlighted == 2 and love.keyboard.wasPressed('enter') or (highlighted == 2 and love.keyboard.wasPressed('return')) then
        print('go to score')
        gStateMachine:change('highScore',{
            highScores = self.highScores
        })
    end

    if highlighted == 3 and love.keyboard.wasPressed('enter') or (highlighted == 3 and love.keyboard.wasPressed('return')) then
        print('go to skins')
        gStateMachine:change('paddleSelect',{
            highScores = self.highScores
        })
    end


    if highlighted == 4 and love.keyboard.wasPressed('enter') or (highlighted == 4 and love.keyboard.wasPressed('return')) then
        love.event.quit()
    end

end

function StartState:render()

    love.graphics.setFont(gFonts['BigFont'])

    love.graphics.printf('Drug Fight', 0, 15, VIRTUAL_WIDTH, 'center')


    love.graphics.setFont(gFonts['DefaultFont'])

    if highlighted == 1 then
        --set the color to red
        love.graphics.setFont(gFonts['HighlightedFont'])
        love.graphics.setColor(1,0,.4,1)
    end

    love.graphics.printf('Start', 0, VIRTUAL_HEIGHT/2+10, VIRTUAL_WIDTH, 'center')


    --set the color back to default
    love.graphics.setFont(gFonts['DefaultFont'])
    love.graphics.setColor(1,1,1,1)

    if highlighted == 2 then
        --set the color to red
        love.graphics.setFont(gFonts['HighlightedFont'])
        love.graphics.setColor(1,0,.4,1)
    end

    love.graphics.printf('Score Board', 0, VIRTUAL_HEIGHT/2+30, VIRTUAL_WIDTH, 'center') 

    --set the color back to default
    love.graphics.setFont(gFonts['DefaultFont'])
    love.graphics.setColor(1,1,1,1)

    if highlighted == 3 then
        --set the color to red
        love.graphics.setFont(gFonts['HighlightedFont'])
        love.graphics.setColor(1,0,.4,1)
    end

    love.graphics.printf('Paddle Skins', 0, VIRTUAL_HEIGHT/2+50, VIRTUAL_WIDTH, 'center')

    --set the color back to default
    love.graphics.setFont(gFonts['DefaultFont'])
    love.graphics.setColor(1,1,1,1)

    if highlighted == 4 then
        --set the color to red
        love.graphics.setFont(gFonts['HighlightedFont'])
        love.graphics.setColor(1,0,.4,1)
    end

    love.graphics.printf('Quit', 0, VIRTUAL_HEIGHT/2+70, VIRTUAL_WIDTH, 'center')

    --set the color back to default
    love.graphics.setFont(gFonts['DefaultFont'])
    love.graphics.setColor(1,1,1,1)

    --love.graphics.rectangle('fill', 170, 0, 100, 500)

    
end

function StartState:enter(params)
    self.highScores = params.highScores
end

function StartState:exit() end