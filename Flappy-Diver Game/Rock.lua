Rock = Class{}

--this is outside the init function because we dont need to creat
--a new image each time we create a rock 
local ROCK_IMG = love.graphics.newImage('Assets/rock.png')
 
ROCK_SPEED = 60

ROCK_HEIGHT = 150
ROCK_WIDTH = 50


function Rock:init(orientation, y)
    self.x = VIRTUAL_WIDTHi
    self.y = y
    self.width = ROCK_IMG:getWidth()
    self.height = ROCK_HEIGHT

    self.orientation = orientation
end

function Rock:update(dt)

end

function Rock:render()
    love.graphics.draw(ROCK_IMG, self.x, (self.orientation == 'top' and self.y or self.y + ROCK_HEIGHT),
        0, -- roataion
        1,  -- X scale
        self.orientation == 'bottom' and -1 or 1) --Y scale
end


