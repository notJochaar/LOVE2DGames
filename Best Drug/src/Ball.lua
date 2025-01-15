
Ball = Class{}

function Ball:init(skin)
    self.x = VIRTUAL_WIDTH/2 -8
    self.y = VIRTUAL_HEIGHT/2 -8

    self.dx = 0
    self.dy = -BALL_SPEED 

    self.width = 8
    self.height = 8

    self.skin = skin
end

function Ball:colides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)
    self.y = self.y + self.dy * dt
    self.x = self.x + self.dx * dt
    
    if self.x <= 0 then
        self.x = 0 
        self.dx = -self.dx
    end

    if self.x >= VIRTUAL_WIDTH - self.width then
        self.x = VIRTUAL_WIDTH - self.width
        self.dx = -self.dx
    end

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
    end

end

function Ball:render()
    love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin], self.x , self.y)
end