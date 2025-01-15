
PowerUp = Class{}

function PowerUp:init(x,y)
    self.x = x
    self.y = y
    
    self.width = 16
    self.height = 16

    self.dy = 0

    self.powerUp = math.random(1,10)
    self.inPlay = true
end

function PowerUp:colides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function PowerUp:update(dt)
    self.dy = POWERUP_SPEED * dt
    self.y = self.y + self.dy
end

function PowerUp:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.powerUp], self.x, self.y)
    end
end