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

-- Exercise 2.2
-- Make another scene by adding more elements to it. Be creative!
-- Suggestions:
--  - Make different shapes: look at the `ngon` function
--  - Change colours; perhaps play with alpha


-- Solution
scene2 : String -> (Int,Int) -> Element
scene2 txt (w,h) =
    container w h middle <|
    collage gameWidth gameHeight
            [ toForm         <| show txt,
              move (50,50)   <| filled blue (oval 100 100),
              move (-70,-70) <| filled yellow (rect 100 100),
              filled red (ngon 5 100)
                       |> alpha 0.5,
              filled purple (ngon 3 120)
                       |> alpha 0.6
            ]

main : Signal Element
main = (scene2 "hello") <~ Window.dimensions
