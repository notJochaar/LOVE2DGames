
StateMachine = Class{}

--this is taking the table of states were sending from the main
function StateMachine:init(states)

    --we are defining a state called empty that does nothing 
    --self.empty acts as a "placeholder state" or "default state" for the state machine
    --it esures that these functions are empty
    --and wont break the game when tries to call these functions
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end, 
        exit = function() end
    }
    --if state has no value then it will be set to an empty table   
    -- /*
    -- The or operator:
    -- Returns the first truthy value it encounters.
    -- If the first value is false or nil, it proceeds to the next value.
    -- */
    self.states = states or {}
    
    --were are setting the current state to the state empty
    self.current = self.empty
end

function StateMachine:update(dt)
    --will update the current state
    self.current:update(dt)     
end

function StateMachine:render()
    --will render the current state
    self.current:render()
end

--this takes the state name we want to enter
function StateMachine:change(stateName, enterParams)
    --  /*
    -- The assert function in Lua is used to check conditions and ensure they are true.
    -- If the condition is false (or nil), assert will raise an error and stop the program.
    -- */
    --checks if its null
    assert(self.states[stateName], "the state name is nil")
    --it will exit the current state
    self.current:exit()
    --will set it to the new state
    self.current = self.states[stateName]()
    --will enter the new state
    self.current:enter(enterParams)
    print("Changing State")
end



