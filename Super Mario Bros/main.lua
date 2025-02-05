
require 'src/Dependencies'

function love.load()

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Super Mario Bros')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    
    gSounds['groundSoundTrack']:setLooping(true)
    gSounds['groundSoundTrack']:setVolume(0.5)
    gSounds['groundSoundTrack']:play()
    
    love.graphics.setFont(gFont['mario'])
end

function love.update(dt)

end

function love.draw()
    push:apply('start')

    
    love.graphics.setColor(1,1,1,1)
    
    love.graphics.draw(gTextures['background'], 0,0)

    love.graphics.draw(gTextures['tilesheet'], 0,0)

    local marginX = 0
    local marginY = 0
    for y = 0, (VIRTUAL_HEIGHT/ TILE_SIZE) do
        for x = 0, (VIRTUAL_WIDTH / TILE_SIZE) do
            love.graphics.draw(gTextures['tilesheet'],gFrames['tileset'][1], marginX , gTextures['background']:getHeight() + marginY)

            marginX = marginX + TILE_SIZE
        end
        marginY = marginY + TILE_SIZE
        marginX = 0
    end
    love.graphics.setColor(1,0.8,0,1)
    
    love.graphics.printf('Super Mario Bros', 0, VIRTUAL_HEIGHT/2 - 40, VIRTUAL_WIDTH, 'center')
    
    push:apply('end')
end

function love.resize(w,h)
    push.resize(w,h)
end