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
import Debug exposing (log, watch)


type H = H

(gameWidth,gameHeight) = (600,400)
(halfWidth,halfHeight) = (300,200)
pongGreen = rgb 60 100 60
textGreen = rgb 160 200 160


-- Exercise 2.3
-- Static shapes are boring. Let's animate the shapes you created above by using the `orbit` functions
-- below.
-- Hint:
--   - look at the variants of map for Signals

time : Signal Float
time =
  Signal.map (inSeconds << fst) (timestamp (fps 40))


orbit : Float -> (Float,Float) -> Form -> Form
orbit angle (x,y) form = move (x * sin angle, y * cos angle) form

orbitCCW : Float -> (Float,Float) -> Form -> Form
orbitCCW angle (x,y) form = move (x * cos angle, y * sin angle) form

scene3 : String -> Float -> (Int,Int) -> Element
scene3 txt angle (w,h) =
    container w h middle <|
    collage gameWidth gameHeight
            [
              H
            ]

main : Signal Element
main = (scene3 "hello") <~ H
