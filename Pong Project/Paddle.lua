--Paddle class

Paddle = Class{}

--paddle constructor
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = 0
end

function Paddle:update(dt)

    if self.dy < 0 then
        --this checks if the player position is more than the border which is 0
        --it will ensure we dont go to the negative side 
        self.y = math.max(0, self.y + self.dy *dt)
    elseif self.dy > 0 then
        --this checks if the player position is more than the border which is VIRTUAL_HEIGHT-50
        --it will ensure we dont go to more than that. 
        self.y = math.min(VIRTUAL_HEIGHT-self.height, self.y + self.dy * dt)
    end
end

function Paddle:render(R,G,B)

    love.graphics.setColor(love.math.colorFromBytes(R,G,B))
    love.graphics.rectangle('fill', self.x , self.y , self.width, self.height)
end
