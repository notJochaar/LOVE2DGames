
StateMachine = Class{}

function StateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }

    --store the given states
    self.states = states or {}

    --the first state
    self.current = self.empty
end

function StateMachine:change(stateName, enterParams)
    --check if state is not nil
    assert(self.states[stateName], 'this state is not found')
    --runs the exit function of the currnet state
    self.current:exit()

    self.current = self.states[stateName]()
    --runs the enter function of the new state
    self.current:enter(enterParams)
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:render()
    self.current:render()
end
