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

delta : Signal Time
delta = inSeconds <~ fps 35

-- Let's thing a little about the game inputs

type Direction   = Up | Stopped | Down
type alias Input = {paddle1:Direction, paddle2:Direction, delta:Time }

dirToInt : Direction -> Int
dirToInt dir =
    case dir of
      Up       -> 1
      Stopped  -> 0
--      Down     -> -1

intToDir : Int -> Direction
intToDir x =
    if | x == 1    -> Up
       | x == (-1) -> Down
       | otherwise -> Stopped



-- Exercise 1.2
-- Using the helper function we defined before `recordToDir`, create a signal that represents the game input over time
-- Hint:
--   - remember `Input` can be used as a function
--   - the overall goal is to build the Input from three Signals


input : Signal Input
input = sampleOn delta <| Input <~ (Signal.map (intToDir << .y) Keyboard.wasd)
                                 ~ (Signal.map (intToDir << .y) Keyboard.arrows)
                                 ~ delta

main : Signal Element
main = Signal.map show input








































--
-- Supporting functions and data structures from previous exercises
--


recordToDir : { x : Int, y : Int } -> Direction
recordToDir = intToDir << .y
