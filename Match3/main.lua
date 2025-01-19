require 'src/Dependencies'

function love.load()
    love.window.setTitle('breakOut')

    love.graphics.setDefaultFilter('nearest','nearest')

    push:setupScreen( VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    font = love.graphics.newFont('font/8-bit Arcade In.ttf', 32)

    love.graphics.setFont(font)


    -- all of the intervals for our labels
    --every integer is incerecing by this value 
    intervals = {1}--, 2, 4, 3, 2, 8}

    -- all of the counters for our labels
    --this stores the integers that are incerecing 
    counters = {0}--, 0, 0, 0, 0, 0}

    -- create Timer entries for each interval and counter
    
    -- anonymous function that gets called every intervals[i], in seconds
    Timer.every(intervals[1], function()
        counters[1] = counters[1] + 1
    end)
    
    --define a block
    block = {y = VIRTUAL_HEIGHT}
    
    Timer.tween(1, {
        [block] = {y = VIRTUAL_HEIGHT/2}
    }):finish(function() 
        Timer.tween(2, {
            [block] = {y = VIRTUAL_HEIGHT/2}
        }):finish(function() 
            Timer.tween(1, {
                [block] = {y = -50}
            })
        end)
    end)
        
    
end


function love.update(dt)
    

    -- perform the actual updates in the functions we passed in via Timer.every
    Timer.update(dt)

    
end



function love.draw()
    push:start()
    love.graphics.clear(0.8,0.3,.3,1)
    
    love.graphics.setColor(1,1,0,1)

    love.graphics.rectangle('fill', 0, block.y, VIRTUAL_WIDTH, 40)

    love.graphics.setColor(0,0,0,1)

    love.graphics.printf('Timer Project', 0, block.y+5, VIRTUAL_WIDTH, 'center') 

    love.graphics.setColor(1,1,1,1)

    --for i = 1, 6 do
        -- reference the counters and intervals table via i here, which is being
        -- updated with the Timer library over time thanks to Timer.update
    love.graphics.printf('Timer ' .. tostring(counters[1]) .. ' seconds every' ..
        tostring(intervals[1]) .. ' ', 0, 54 + 1 * 16, VIRTUAL_WIDTH, 'center')
    --end

    push:finish()
end

function love.resize(w, h)
    push:resize(w,h)
end