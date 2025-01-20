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

    tileSprite = love.graphics.newImage('graphics/match3.png')    
    
    tileQuads = GenerateQuads(tileSprite, 32, 32)

    board = generateBoard()
end


function love.update(dt)
    

    -- perform the actual updates in the functions we passed in via Timer.every
    Timer.update(dt)

    
end



function love.draw()
    push:start()
    love.graphics.clear(0.8,0.3,.3,1)
    
    drawBoard(128, 16)

    push:finish()
end

function generateBoard()
    local tiles = {}

        for y = 1,8 do
            table.insert(tiles,{})

            for x = 1, 8 do
                table.insert(tiles[y], {
                    x = (x - 1) * 32,
                    y = (y - 1) * 32,

                    tile = math.random(#tileQuads)
                })
            end
        end

    return tiles
end

function drawBoard(offsetX, offsetY)
    for y = 1 , 8 do
        for x = 1, 8 do
            local tile = board[y][x]

            love.graphics.draw(tileSprite, tileQuads[tile.tile], 
                tile.x + offsetX, tile.y + offsetY)
        end
    end
end

function love.resize(w, h)
    push:resize(w,h)
end
