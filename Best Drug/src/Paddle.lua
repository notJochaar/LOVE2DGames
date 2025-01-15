
Paddle = Class{}

function Paddle:init(skin)
    self.x = VIRTUAL_WIDTH/2 
    self.y = VIRTUAL_HEIGHT - 32

    self.dx = 0

    self.width = 64
    self.height = 16

    --skin will only change the colors
    self.skin = skin

    --we will start with the second size
    self.size = 2

end

function Paddle:update(dt)

    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else 
        self.dx = 0
    end

    if self.dx > 0 then
        self.x = math.min(self.x + self.dx * dt, VIRTUAL_WIDTH - self.width)
    else
        self.x = math.max(self.x + self.dx * dt, 0)
    end

end

function Paddle:render()
    --the multiplication of size an skin will give us the number of paddle we want to render
    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.size + 4 * (self.skin -1)], self.x , self.y)
end