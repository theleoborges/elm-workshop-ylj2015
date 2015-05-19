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
      Down     -> -1

intToDir : Int -> Direction
intToDir x =
    if | x == 1    -> Up
       | x == (-1) -> Down
       | otherwise -> Stopped



-- Exercise 1.1
-- Create a signal that represents the game input over time
--
-- As an example, consider the following Signal
--
keysOverTime : Signal ({ x : Int, y : Int }, { x : Int, y : Int })
keysOverTime = sampleOn delta <| Signal.map2 (,) Keyboard.wasd Keyboard.arrows

-- main : Signal Element
-- main = Signal.map show keysOverTime


-- ... however we would like a Signal that represents the Input type we defined above, with the following type:


--
-- Solution
--
input : Signal Input
input = sampleOn delta <| Input <~ Signal.map (intToDir << .y) Keyboard.wasd
                                 ~ Signal.map (intToDir << .y) Keyboard.arrows
                                 ~ delta


-- above can also be written as
-- input' : Signal Input
-- input' = sampleOn delta <| Signal.map3 Input (Signal.map (intToDir << .y) Keyboard.wasd)
--                                              (Signal.map (intToDir << .y) Keyboard.arrows)
--                                              delta

main : Signal Element
main = Signal.map show input
