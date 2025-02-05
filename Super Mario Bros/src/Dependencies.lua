Class = require 'lib/class'
push = require 'lib/push'

require 'conf'


require 'src/constants'
require 'src/Util'


--controls the states
require 'src/StateMachine'

--the states




--Global Objects

gFont = {
    ['mario'] = love.graphics.newFont('assets/font/super_mario_256/SuperMario256.ttf', 32)
}

gTextures = {
    ['background'] = love.graphics.newImage('assets/graphics/background1.png'),
    ['tilesheet'] = love.graphics.newImage('assets/graphics/tileset1.png')
}

gSounds = {
    ['groundSoundTrack'] = love.audio.newSource('assets/sound/01. Ground Theme.mp3', 'static')
}

gFrames = {
    ['tileset'] = GenerateQuads(gTextures['tilesheet'], TILE_SIZE, TILE_SIZE)
}