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

    highlightedTile = false
    highlightedX, highlightedY = 1, 1
    selectedTile = board[1][1]
end


function love.update(dt)
    

    -- perform the actual updates in the functions we passed in via Timer.every
    Timer.update(dt)

    
end

function love.keypressed(key) 
    if key == 'escape' then
        love.event.quit()
    end

    local x, y = selectedTile.gridX, selectedTile.gridY

    if key == 'up' then
        if y > 1 then
            selectedTile = board[y - 1][x]
        end
    end
    if key == 'down' then
        if y < 8 then
            selectedTile = board[y + 1][x]
        end
    end
    if key == 'left' then
        if x > 1 then
            selectedTile = board[y][x - 1]
        end
    end
    if key == 'right' then
        if x < 8 then
            selectedTile = board[y][x + 1]
        end
    end
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

                    -- now we need to know what tile X and Y this tile is
                    gridX = x,
                    gridY = y,
                    
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

                -- draw highlight on tile if selected
            if highlightedTile then
                if tile.gridX == highlightedX and tile.gridY == highlightedY then
                    
                    -- half opacity so we can still see tile underneath
                    love.graphics.setColor(1, 1, 1, 128/255)

                    -- rounded rectangle with the 4 at the end (corner segments)
                    love.graphics.rectangle('fill', tile.x + offsetX, tile.y + offsetY, 32, 32, 4)

                    -- reset color back to default
                    love.graphics.setColor(1, 1, 1, 1)
                end
            end
        end
    end

    -- drawing currently selected tile:
    
    
    -- thicker line width than normal
    
    love.graphics.setColor(1, 1, 1, 0.1)
    
    love.graphics.rectangle('fill', selectedTile.x + offsetX, selectedTile.y + offsetY, 32, 32, 4)

    love.graphics.setLineWidth(2)
    
    love.graphics.setColor(1, 1, 1, 234/255)
    -- line rect where tile is
    love.graphics.rectangle('line', selectedTile.x + offsetX, selectedTile.y + offsetY, 32, 32, 4)

    -- reset default color
    -- love.graphics.setColor(1, 1, 1, 1)
end


function love.resize(w, h)
    push:resize(w,h)
end
