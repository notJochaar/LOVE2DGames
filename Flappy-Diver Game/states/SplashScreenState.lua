

--__includes = BaseState , this is how to implemet another class 
-- BaseState is the parent class
SplashScreenState = Class{__includes = BaseState}

function SplashScreenState:init() 
    self.timer = 0
    self.opacity = 0
    self.panel = 1
end

function SplashScreenState:update(dt) 
    
   

    if self.timer > 3 and self.timer < 3.1  then
        self.opacity = 0
        self.panel = 2
    end
    if self.timer > 6 and self.timer < 6.1  then
        self.opacity = 0
        self.panel = 3
    end

    print(self.timer)

    self.timer = self.timer + dt
    self.opacity = (self.opacity +dt/2)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') and self.timer > 10 then
        print("working")
        scrolling = true
        audio['start']:play()
        gStateMachine:change('count')
    end 
end

function SplashScreenState:render() 

    if self.panel == 1 then
        love.graphics.setFont(BigFont)
        love.graphics.setColor(1,1,1, self.opacity)
        love.graphics.printf('Made By notJochaar', 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1,1,1, 1)
    end

    if self.panel == 2 then
        love.graphics.setFont(BigFont)
        love.graphics.setColor(1,1,1, self.opacity)
        love.graphics.printf('Made In LOVE2D', 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1,1,1, 1)
    end

    if self.panel == 3 then

        love.graphics.setFont(CurlyFont)
        love.graphics.setColor(1,1,1, self.opacity)
        love.graphics.printf('Flappy Diver', 0, 25, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(SmallFont)
        love.graphics.printf('Press Enter To Start', 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(DefaultFont)
        love.graphics.printf('V1.0', 0, VIRTUAL_HEIGHT-20, VIRTUAL_WIDTH, 'right')
        love.graphics.setColor(1,1,1, 1)
        --love.graphics.setColor(1,1,1,.3)
        --love.graphics.printf('By Saeed Alsuwaidi', 0, 0, VIRTUAL_WIDTH, 'center')
    end
end