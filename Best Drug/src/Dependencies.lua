Class = require 'lib/class'
push = require 'lib/push'

require 'conf'


require 'src/constants'

require 'src/Paddle'
require 'src/Ball'
require 'src/Brick'
require 'src/PowerUp'

--Util files mainly are for functions that we will be using on the whole project
--our utility functions, mainly for splitting our sprite sheet into various Quads
-- of differing sizes for paddles, balls, bricks, etc.
require 'src/Util'
require 'src/LevelMaker'
--controls the states
require 'src/StateMachine'

--the states
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/ServeState'
require 'src/states/GameOverState'
require 'src/states/VictoryState'
require 'src/states/HighScoreState'
require 'src/states/EnterHighScoreState'
require 'src/states/PaddleSelectState'

