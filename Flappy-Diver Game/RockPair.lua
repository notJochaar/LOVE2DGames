
RockPair = Class{}

--the gap between rocks
local GAP_HEIGHT = math.random(50,90)

function RockPair:init(y)
    self.x = VIRTUAL_WIDTH + 30
    self.y = y

    self.rocks = {
        ['upper'] = Rock('top', y),
        ['lower'] = Rock('bottom', self.y + ROCK_HEIGHT + GAP_HEIGHT)
    }


    self.remove = false

    self.scored = false
end

function RockPair:update(dt)
    GAP_HEIGHT = math.random(50,90)

    if self.x > -ROCK_WIDTH then
        self.x = self.x - ROCK_SPEED *dt
        self.rocks['upper'].x = self.x
        self.rocks['lower'].x = self.x
    else
        self.remove = true
    end

end

function RockPair:render()
    for K, rock in pairs(self.rocks) do
        rock:render()
    end
end

-- /*when can i make a bigger gap and a small gap without showing the bottom of the rock?
-- screen height is 400

-- the rock height is 100

-- if the top rock y is -90 then it will end at 10 the bottom rock should start at 300
-- or i can make the rock taller at least 250
-- *\

