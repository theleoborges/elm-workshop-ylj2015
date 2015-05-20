import Graphics.Element exposing (..)
import Time
import Window
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Keyboard
import Text exposing (monospace, fromString)
import Time exposing (..)
import Window
import Signal exposing ((<~), (~), foldp, sampleOn)
import Debug exposing (log)

{-- Part 1: Model the user input ----------------------------------------------

What information do you need to represent all relevant user input?

Task: Redefine `UserInput` to include all of the information you need.
      Redefine `userInput` to be a signal that correctly models the user
      input as described by `UserInput`.

------------------------------------------------------------------------------}
type Direction   = Up | Stopped | Down
type alias Input = { space:Bool, paddle1:Direction, paddle2:Direction, delta:Time }

-- <~ same as map
delta : Signal Time
delta = inSeconds <~ fps 35


dirToInt : Direction -> Int
dirToInt dir =
    case dir of
      Up       -> 1
      Stopped  -> 0
      Down     -> -1

intToDir : Int -> Direction
intToDir x =
    if | x == 1    -> Up
       | x == (-1) -> Down
       | otherwise -> Stopped


-- <~ signal ~ signal -- same as map2. Think of it as mapN
input : Signal Input
input = sampleOn delta <| Input <~ Keyboard.space
                                 ~ Signal.map (intToDir << .y) Keyboard.wasd
                                 ~ Signal.map (intToDir << .y) Keyboard.arrows
                                 ~ delta

{-- Part 2: Model the game ----------------------------------------------------

What information do you need to represent the entire game?

Tasks: Redefine `GameState` to represent your particular game.
       Redefine `defaultGame` to represent your initial game state.

For example, if you want to represent many objects that just have a position,
your GameState might just be a list of coordinates and your default game might
be an empty list (no objects at the start):

    type GameState = { objects : [(Float,Float)] }
    defaultGame = { objects = [] }

------------------------------------------------------------------------------}

(gameWidth,gameHeight) = (600,400)
(halfWidth,halfHeight) = (300,200)

type alias Object a = { a | x:Float, y:Float, vx:Float, vy:Float }

type alias Ball = Object {}

type alias Score  = Int
type alias Player = Object { score:Score }


type State = Play | Pause



type alias Game = { state:State, ball:Ball, player1:Player, player2:Player }

player : Float -> Player
player x = { x=x, y=0, vx=0, vy=0, score=0 }

defaultGame : Game
defaultGame =
  { state   = Pause
  , ball    = { x=0, y=0, vx=200, vy=200 }
  , player1 = player (20-halfWidth)
  , player2 = player (halfWidth-20)
  }




{-- Part 3: Update the game ---------------------------------------------------

How does the game step from one state to another based on user input?

Task: redefine `stepGame` to use the UserInput and GameState
      you defined in parts 1 and 2. Maybe use some helper functions
      to break up the work, stepping smaller parts of the game.

------------------------------------------------------------------------------}

-- are n and m near each other?
-- specifically are they within c of each other?
near : Float -> Float -> Float -> Bool
near n c m = m >= n-c && m <= n+c

-- is the ball within a paddle?
-- |> is like thread last in Clojure
within : Ball -> Player -> Bool
within ball player =
    (ball.x |> near player.x 8) && (ball.y |> near player.y 20)

-- change the direction of a velocity based on collisions
stepV : Float -> Bool -> Bool -> Float
stepV v lowerCollision upperCollision =
  if | lowerCollision -> abs v
     | upperCollision -> 0 - abs v
     | otherwise      -> v




-- step the position of an object based on its velocity and a timestep
stepObj : Time -> Object a -> Object a
stepObj t ({x,y,vx,vy} as obj) =
    { obj | x <- x + vx * t
          , y <- y + vy * t }

-- move a ball forward, detecting collisions with either paddle
stepBall : Time -> Ball -> Player -> Player -> Ball
stepBall t ({x,y,vx,vy} as ball) player1 player2 =
  if not (ball.x |> near 0 halfWidth)
  then { ball | x <- 0, y <- 0 }
  else
    let vx' = stepV vx (ball `within` player1) (ball `within` player2)
        vy' = stepV vy (y < 7-halfHeight) (y > halfHeight-7)
    in
        stepObj t { ball | vx <- vx', vy <- vy' }

-- step a player forward, making sure it does not fly off the court
stepPlyr : Time -> Direction -> Score -> Player -> Player
stepPlyr t dir points player =
    let dir'    = dirToInt dir
        player' = stepObj t { player | vy <- toFloat dir' * 200 }
        y'      = clamp (22-halfHeight) (halfHeight-22) player'.y
        score'  = player.score + points
    in
      { player' | y <- y', score <- score' }



stepGame : Input -> Game -> Game
stepGame {space,paddle1,paddle2,delta}
         ({state,ball,player1,player2} as game) =
  let paddle1' = dirToInt paddle1
      paddle2' = dirToInt paddle2
      score1 = if ball.x >  halfWidth then 1 else 0
      score2 = if ball.x < -halfWidth then 1 else 0

      state' = if | space            -> Play
                  | score1 /= score2 -> Pause
                  | otherwise        -> state

      ball' = if state == Pause then ball else
                  stepBall delta ball player1 player2

      player1' = stepPlyr delta paddle1 score1 player1
      player2' = stepPlyr delta paddle2 score2 player2
  in
      { game | state   <- state'
             , ball    <- ball'
             , player1 <- player1'
             , player2 <- player2' }


gameState : Signal Game
gameState = foldp stepGame defaultGame input



{-- Part 4: Display the game --------------------------------------------------

How should the GameState be displayed to the user?

Task: redefine `display` to use the GameState you defined in part 2.

------------------------------------------------------------------------------}



-- helper values
pongGreen = rgb 60 100 60
textGreen = rgb 160 200 160
txt f = leftAligned << f << monospace << Text.color textGreen << fromString
msg = "SPACE to start, WS and &uarr;&darr; to move"

-- shared function for rendering objects
displayObj : Object a -> Shape -> Form
displayObj obj shape =
    move (obj.x,obj.y) (filled white shape)

-- display a game state
display : (Int,Int) -> Game -> Element
display (w,h) {state,ball,player1,player2} =
  let scores : Element
      scores = txt (Text.height 50) <|
               toString player1.score ++ "  " ++ toString player2.score
  in
      container w h middle <|
      collage gameWidth gameHeight
       [ filled pongGreen   (rect gameWidth gameHeight)
       , displayObj ball    (oval 15 15)
       , displayObj player1 (rect 10 40)
       , displayObj player2 (rect 10 40)
       , toForm scores
           |> move (0, gameHeight/2 - 40)
       , toForm (if state == Play then spacer 1 1 else txt identity msg)
           |> move (0, 40 - gameHeight/2)
       ]



main = Signal.map2 display Window.dimensions gameState
