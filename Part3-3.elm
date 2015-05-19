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


type H = H


--
-- Animating the ball
--
-- First some helper functions

-- are n and m near each other?
-- specifically are they within c of each other?
near : Float -> Float -> Float -> Bool
near n c m = m >= n-c && m <= n+c

-- is the ball within a paddle?
-- |> is 'like' thread last in Clojure
within : Ball -> Player -> Bool
within ball player =
    (ball.x |> near player.x 8) && (ball.y |> near player.y 20)

-- change the direction of a velocity based on collisions
stepV : Float -> Bool -> Bool -> Float
stepV v lowerCollision upperCollision =
  if | lowerCollision -> abs v
     | upperCollision -> 0 - abs v
     | otherwise      -> v

stepBall : Time -> Ball -> Player -> Player -> Ball
stepBall t ({x,y,vx,vy} as ball) player1 player2 =
  if not (ball.x |> near 0 halfWidth)
  then { ball | x <- 0, y <- 0 }
  else
    let vx' = stepV vx (ball `within` player1) (ball `within` player2)
        vy' = stepV vy (y < 7-halfHeight) (y > halfHeight-7)
    in
        stepObj t { ball | vx <- vx', vy <- vy' }


-- Exercise 3.3
-- Update `stepGame` to take into account animating the ball using the supporting functions above

-- Solution
stepGame : Input -> Game -> Game
stepGame {paddle1,paddle2,delta}
         ({player1,player2,ball} as game) =
  let paddle1' = dirToInt paddle1
      paddle2' = dirToInt paddle2

      player1' = stepPlyr delta paddle1 player1
      player2' = stepPlyr delta paddle2 player2
      ball'    = stepBall delta ball player1 player2

  in
      { game | player1 <- player1'
             , player2 <- player2'
             , ball    <- ball'}


main = Signal.map2 display Window.dimensions gameState


-- Enjoy the game!


-- Want more?
-- If you would like to explore this example further, a good first step is to make it match the original Pong game
-- found on the Elm website. To reach parity, try and implement:
--   - The ability to pause the game by pressing SPACE
--   - Displaying of scores
-- more at: http://elm-lang.org/blog/Pong.elm






















































--
-- Supporting functions and data structures from previous exercises
--

type alias Object a = { a | x:Float, y:Float, vx:Float, vy:Float }

type alias Score  = Int
type alias Player = Object {}
type alias Ball   = Object {}

player : Float -> Player
player x = { x=x, y=0, vx=0, vy=0 }

defaultBall : Ball
defaultBall = { x=0, y=0, vx=200, vy=200 }

type alias Game = { player1:Player, player2:Player, ball: Ball }

defaultGame : Game
defaultGame =
  { player1 = player (20-halfWidth),
    player2 = player (halfWidth-20),
    ball    = defaultBall
  }


-- generic function that moves objects
stepObj : Time -> Object a -> Object a
stepObj t ({x,y,vx,vy} as obj) =
    { obj | x <- x + vx * t
          , y <- y + vy * t }

-- step a player forward, making sure it does not fly off the court
stepPlyr : Time -> Direction -> Player -> Player
stepPlyr t dir player =
    let dir'    = dirToInt dir
        player' = stepObj t { player | vy <- toFloat dir' * 200 }
        y'      = clamp (22-halfHeight) (halfHeight-22) player'.y -- explain clamp
    in
      { player' | y <- y'}

gameState : Signal Game
gameState = foldp stepGame defaultGame input


displayObj : Object a -> Shape -> Form
displayObj obj shape =
    move (obj.x,obj.y) (filled white shape) -- H

display : (Int,Int) -> Game -> Element
display (w,h) {player1,player2, ball} =
  container w h middle <|
  collage gameWidth gameHeight
              [ filled pongGreen (rect gameWidth gameHeight),
                displayObj player1 (rect 10 40),
                displayObj player2 (rect 10 40),
                displayObj ball    (oval 15 15)
              ]


(gameWidth,gameHeight) = (600,400)
(halfWidth,halfHeight) = (300,200)
pongGreen = rgb 60 100 60
textGreen = rgb 160 200 160

type Direction   = Up | Stopped | Down
type alias Input = {paddle1:Direction, paddle2:Direction, delta:Time }

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
input = sampleOn delta <| Input <~ Signal.map (intToDir << .y) Keyboard.wasd
                                 ~ Signal.map (intToDir << .y) Keyboard.arrows
                                 ~ delta
