require 'src/Dependencies'

function love.load()
    love.window.setTitle('breakOut')

    love.graphics.setDefaultFilter('nearest','nearest')

    push:setupScreen( VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    font = love.graphics.newFont('font/8-bit Arcade In.ttf', 26)

    love.graphics.setFont(font)

    currentSecond = 0
    secondTimer = 0

        -- all of the intervals for our labels
        intervals = {1, 2, 4, 3, 2, 8}

        -- all of the counters for our labels
        counters = {0, 0, 0, 0, 0, 0}
    
        -- create Timer entries for each interval and counter
        for i = 1, 6 do
            -- anonymous function that gets called every intervals[i], in seconds
            Timer.every(intervals[i], function()
                counters[i] = counters[i] + 1
            end)
        end

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

    -- perform the actual updates in the functions we passed in via Timer.every
    Timer.update(dt)

    
end



function love.draw()
    push:start()
    love.graphics.clear(0.8,0.3,.3,1)
    
    for i = 1, 6 do
        -- reference the counters and intervals table via i here, which is being
        -- updated with the Timer library over time thanks to Timer.update
        love.graphics.printf('Timer ' .. tostring(counters[i]) .. ' seconds every' ..
            tostring(intervals[i]) .. ' ', 0, 54 + i * 16, VIRTUAL_WIDTH, 'center')
    end

    push:finish()
end

function love.resize(w, h)
    push:resize(w,h)
end