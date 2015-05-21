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


-- Exercise 2.7
-- Finally, add the ball to the center of the court. Any size will do but 15x15 works well :)

ball : Color -> Float -> Form
ball c w = H


display : (Int,Int) -> Element
display (w,h) =
  H

main = Signal.map display Window.dimensions







































--
-- Supporting functions and data structures from previous exercises
--


court : Float -> Float -> Form
court w h = filled pongGreen (rect w h)

paddle : Color -> Float -> Float -> Form
paddle c w h = filled c (rect w h)
