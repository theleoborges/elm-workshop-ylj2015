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

--
-- Part 1 - Signals and inputs
--


-- Some built-in signals

main : Signal Element
main = Signal.map show Keyboard.space

--main = Signal.map show (fps 35)
--main = Signal.map show Keyboard.wasd
--main = Signal.map show Keyboard.arrows
