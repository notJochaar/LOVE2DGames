--this is consederd as an interface for the other States
--the ther states will inheret and implemet these methods

BaseState = Class{}

function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end