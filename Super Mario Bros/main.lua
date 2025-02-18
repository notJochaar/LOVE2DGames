
require 'src/Dependencies'

function love.load()

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Super Mario Bros')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    
    gSounds['groundSoundTrack']:setLooping(true)
    gSounds['groundSoundTrack']:setVolume(0.5)
    gSounds['groundSoundTrack']:play()
    
    love.graphics.setFont(gFont['mario'])

    tiles = {
        
    }

    counter = 1

    mapWidth = 30
    mapHeight = 15


    for y = 1, mapHeight do

        --insert a blank table into our main table
        table.insert(tiles, {})
        
            
        for x = 1, mapWidth do
            --this will insert data inside the first object in the table
            table.insert(tiles[y], {
                id = y < 12 and SKY or GROUND
            })
            --[[
                -the result of this loop will be
                -the y loop will insert an object to the table,
                -the x loop will insert some values to an object

                tiles{
                    {id = SKY, id = SKY},
                    {id = SKY, id = SKY}
                }

            ]]--
            
        end
    end

end

function love.update(dt)
    
end

function love.draw()
    push:apply('start')

    
    love.graphics.setColor(1,1,1,1)
    
    love.graphics.draw(gTextures['background'], 0,0)

    for y = 1, mapHeight do
        for x = 1, mapWidth do

            --this will get the id of the tile
            local tile = tiles[y][x]

            love.graphics.draw(gTextures['tilesheet'], gFrames['tileset'][tile.id], (x-1) * TILE_SIZE, (y-1) * TILE_SIZE)

        end
    end


    love.graphics.setColor(1,0.8,0,1)
    
    love.graphics.printf('Super Mario Bros', 0, VIRTUAL_HEIGHT/2 - 40, VIRTUAL_WIDTH, 'center')
    
    push:apply('end')
end

function love.resize(w,h)
    push:resize(w,h)
end