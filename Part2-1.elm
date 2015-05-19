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


textBox : String -> (Int,Int) -> Element
textBox txt (w,h) = container w h middle <| show txt

-- Exercise 2.1
-- Make a Signal such that our text box is responsive.
-- Hint:
--  - Maybe Elm provides a window dimension Signal we can respond to?

-- Solution
main : Signal Element
main = (textBox "hello") <~ Window.dimensions
