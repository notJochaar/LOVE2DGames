

Submarine = Class{}

GRAVITY = 1.5

JUMP_FORCE = -0.65

function Submarine:init()

    self.img = love.graphics.newImage('Assets/Submarine.png')

    --an image object has multiple methods you can call, for example getWidth() 
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()

    self.x = VIRTUAL_WIDTH/3.2
    self.y = VIRTUAL_HEIGHT/2

    self.rotation = 0
    self.dy = 0
    self.startRotation = false
end 

function Submarine:update(dt)

    self.dy = self.dy + GRAVITY*dt

    --this is the function we created, 
    --it will check if the button pressed is in owr table
    --and it will return truebci
    if love.keyboard.wasPressed('space') then
        self.dy = JUMP_FORCE

        audio['jump']:play()
        
        self.startRotation = true
    end


    if self.startRotation == true then

        --rotate up
        if self.rotation > -.9 then
            self.rotation = self.rotation - dt*10
        else
            self.startRotation = false
        end

    else
        if self.rotation < .3 then
            self.rotation = self.rotation + dt*2
            print(self.rotation)
        end
    end

    -- if self.rotation < 0 then
    --     self.rotation = self.rotation + dt
    -- end

    self.y = self.y + self.dy

    
end

function Submarine:render()
    --this color to deepen the color of the submarine 
    --giving the effect that its underwater
    --love.graphics.setColor(0.7,0.9,1,1)
    love.graphics.draw(self.img, self.x, self.y , self.rotation)
end

function Submarine:colides(rock) --AABB collition (Axis Aligned bounding Box)
    if (self.x + 2) + (self.width - 20) >= rock.x and self.x + 10 <= rock.x + ROCK_WIDTH then
        if (self.y + 2) + (self.height - 4) >= rock.y and self.y + 2 <= rock.y + ROCK_HEIGHT then
            return true
        end 
    end

    return false
end 