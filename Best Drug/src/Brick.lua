 Brick = Class{}

 paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    },
    -- gold
    [5] = {
        ['r'] = 251,
        ['g'] = 242,
        ['b'] = 54
    }
}


function Brick:init(x,y)
    self.x = x
    self.y = y

    self.width = 32
    self.height = 16

    self.tier = 0
    self.color = 1

    --check if the brick is exists or not
    self.inPlay = true

    --particle system
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 50)

     -- Configure particle behavior
     self.psystem:setParticleLifetime(0.5, 1)       -- Particles live between 0.5 and 1.5 seconds
     self.psystem:setSizeVariation(1)                -- Particles vary in size
     self.psystem:setLinearAcceleration(-200, -200, 200, 200)
     self.psystem:setEmissionArea('normal', 2, 2)
 
end


function Brick:hit()
    -- set the particle system to interpolate between two colors; in this case, we give
    -- it our self.color but with varying alpha; brighter for higher tiers, fading to 0
    -- over the particle's lifetime (the second color)
    self.psystem:setColors(
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        55 * (self.tier + 1) / 255,
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        0
    )
    self.psystem:emit(50)

    --if were already at the lowest, color else go down a color
    if self.tier > 0 then
        if self.color == 1 then
            self.tear = self.tear - 1
            self.color = 5
        else
            self.color = self.color -1
        end
    else
        if self.color == 1 then
            self.inPlay = false
        else
            self.color = self.color - 1
        end
    end 
end

function Brick:update(dt)
    self.psystem:update(dt)
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], 
            gFrames['bricks'][1 +((self.color - 1) * 4) + self.tier], self.x, self.y)
    end
end

function Brick:renderParticles()
   
    love.graphics.draw(self.psystem, self.x + self.width / 2, self.y + self.height / 2)
end