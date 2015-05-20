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

--
--
-- Part 2 - graphics
--

--

(gameWidth,gameHeight) = (600,400)
(halfWidth,halfHeight) = (300,200)
pongGreen = rgb 60 100 60
textGreen = rgb 160 200 160



-- Containers
textBox : String -> (Int,Int) -> Element
textBox txt (w,h) = container w h middle <| show txt

main : Element
main = textBox "hello" (200,200)
