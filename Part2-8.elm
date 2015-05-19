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

-- Solution
display : (Int,Int) -> Element
display (w,h) =
  container w h middle <|
  collage gameWidth gameHeight
              [ filled pongGreen (rect gameWidth gameHeight),
                move (20-halfWidth, 0) (filled white (rect 10 40)),
                move (halfWidth-20, 0) (filled white (rect 10 40)),
                move (0,0)             (filled white (oval 15 15))
              ]

main = Signal.map display Window.dimensions
