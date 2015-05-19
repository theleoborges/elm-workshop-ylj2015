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

-- Exercise 2.4
-- Based on the what we've learned so far, create a function `displayCourt` that renders a scene
-- with the court in it
-- Hints:
--   - use the colours and game dimensions defined above for the size of the court
--   - the functions `containter` and `collage` might also be useful here


-- Solution
displayCourt : (Int,Int) -> Element
displayCourt (w,h) =
  container w h middle <|
  collage gameWidth gameHeight
   [ filled pongGreen   (rect gameWidth gameHeight)]


main = Signal.map displayCourt Window.dimensions
