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


-- Exercise 2.5
-- Using the same ideas from the previous exercise, create a scene with a paddle of dimensions 10x40 in it.
-- Since we'll draw on white background, make sure the paddle is any colour other than white

displayPaddle : (Int,Int) -> Element
displayPaddle (w,h) =
  H

main = Signal.map displayPaddle Window.dimensions
