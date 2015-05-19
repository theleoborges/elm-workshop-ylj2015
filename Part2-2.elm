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

--
-- Collages
--

scene : String -> (Int,Int) -> Element
scene txt (w,h) =
    container w h middle <|
    collage gameWidth gameHeight
            [ toForm         <| show txt,
              move (50,50)   <| filled blue (oval 100 100),
              move (-70,-70) <| filled yellow (rect 100 100)
            ]

main : Signal Element
main = (scene "hello") <~ Window.dimensions
