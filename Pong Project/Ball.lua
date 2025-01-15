-- Ball Class --

--defines a new class by the name Ball
Ball = Class{}

--class constructor
function Ball:init(x,y, width, height)

    --defining attributes 
    self.x = x
    self.y = y
    
    self.width = width
    self.height = height

    --these attributes are defined by the random
    --ball velocity equals a random number 
    -- it will be either 1 or 2, if it was one then go right
    -- if it is not 1 then go left
    --this is the way to write a tirnary operation in lua
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-200, 200)
end

--reset the ball and put it in the middle of the screen
function Ball:reset()
    self.x = VIRTUAL_WIDTH/2-5
    self.y = VIRTUAL_HEIGHT/2-5
        
    --give the ball a random velocity 
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-200, 200)
end

--instead of putting everything in the main update 
--we can just call the update of every object
--this will save alot of time
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

--this is called form the main draw
-- renders the object from the class instead of the main
function Ball:render(R, G, B)
    love.graphics.setColor(love.math.colorFromBytes(R,G,B))
    --the ball
    love.graphics.rectangle('fill', self.x , self.y , self.width, self.height)
end

function Ball:collides(paddle)
    --check if the ball is on the right or the left of the paddle
    --and its not touching it
    if self.x > paddle.x + paddle.width or self.x + self.width < paddle.x then 
        return false
    end

    --check if the ball is on the right or the left of the paddle
    --and its not touching it
    if self.y > paddle.y + paddle.height or self.y + self.height < paddle.y then 
        return false
    end
    
    --if it wasnt all of these condition
    --then it is touching the paddle so return true
    return true
        
end