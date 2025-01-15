require 'src/Dependencies'

function love.load()
    love.window.setTitle('breakOut')

    love.graphics.setDefaultFilter('nearest','nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        resizable = true,
        fullscreen = false,
        vsync = true
    })

    currentSecond = 0
    secondTimer = 0
end


function love.update(dt)
    --this will count the real time seconds
    secondTimer = secondTimer + dt

    --if second Timer is more than 1
    if secondTimer > 0.5 then
        --incereace the currentSecond by 1
        currentSecond = currentSecond + 1 

        --reset secondTimer to 0
        secondTimer = secondTimer % 0.5
    end

end



function love.draw()

    love.graphics.clear(0.8,0.3,.3,1)

    love.graphics.printf(tostring(currentSecond), 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
end

function love.resize(w, h)
    push:resize(w,h)
end