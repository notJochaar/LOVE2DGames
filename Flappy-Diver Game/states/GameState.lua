

GameState = Class{__includes = BaseState}



function GameState:init() 
--submarine class
 self.submarine = Submarine()
 self.rockPair = {}
 self.spawnTimer = 0
 self.score = 0

 self.lastY = -ROCK_HEIGHT + math.random(80)+ 20

 scoreText = "Score ",self.score
end

function GameState:update(dt) 

    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer > 2 then

        --setting the boundries of the rock generation in the y-axis
        --math.min adds a random number to the last y so the next rock wont be too far
        --this line takes the new Y if it is more than the top boundry
        --and if it is less than the lower boundery
        local y = math.max(-ROCK_HEIGHT + 10, 
            math.min(self.lastY + math.random(-40, 40), -90))

        self.lastY = y
        print("Variable Y:", y)
        table.insert(self.rockPair , RockPair(y))
        self.spawnTimer = 0
    end

    --check for every rock pair in the list 'rockPair'
    for k, pair in pairs(self.rockPair) do
        --check for every rock in the list rocks inside the 'pair' object
        if  not pair.scored then
            if pair.x + ROCK_WIDTH < self.submarine.x then
                self.score = self.score+1
                pair.scored = true
            end
        end

        pair:update(dt)
    end

    --check for every rock pair in the list 'rockPair'
    for k, pair in pairs(self.rockPair) do
        --check for every rock in the list rocks inside the 'pair' object
        for c, rock in pairs(pair.rocks) do 
            --check if the submarine is colliding with that rock
            if self.submarine:colides(rock) then

                audio['death']:play()
                
                gStateMachine:change('score',{

                    score = self.score

                })
            end
        end
    end

    --if we fall of the screen
    if self.submarine.y > VIRTUAL_HEIGHT then

        audio['fall']:play()

        gStateMachine:change('score',{
            score = self.score
        })

    end
    
        --we have a variable to check if we should remove if true then remove
    for k, pair in pairs(self.rockPair) do
        if pair.remove then
            table.remove(self.rockPair, k)
        end
    end 

    self.submarine:update(dt)

end

function GameState:render() 

    for k, pair in pairs(self.rockPair) do
        pair:render()
    end
    
    self.submarine:render()

    love.graphics.setFont(BigFont)
    love.graphics.printf("Score ".. tostring(self.score) , 0, VIRTUAL_HEIGHT-20 , VIRTUAL_WIDTH, 'left')
    
    love.graphics.setFont(SmallFont)
    love.graphics.print(':',82,  VIRTUAL_HEIGHT-8)

end

function GameState:enter() 

end

function GameState:exit() 

end