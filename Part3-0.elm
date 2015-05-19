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
-- First steps towards Game state
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


main = show defaultGame



































--
-- Supporting functions and data structures from previous exercises
--

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
