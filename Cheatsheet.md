# Elm cheatsheet

## Comments

    -- a single line comment
    
    {- a multiline comment
       {- can be nested -}
    -}
    
    

## Records
    
    point = { x = 3, y = 4 }       -- create a record
    
    point.x                        -- access field
    map .x [point,{x=0,y=0}]       -- field access function    
    
    
## Functions

    square n = n^2
    
    hypotenuse a b = sqrt (square a + square b)
    
    distance (a,b) (x,y) = hypotenuse (a-x) (b-y)

### Anonymous functions

    square = \n -> n^2
    squares = map (\n -> n^2) [1..100]    
    
    
### Backward function application

Useful for avoiding parenthesis:

    leftAligned (monospace (fromString "code"))

    -- This can also be written as:
    
    leftAligned << monospace <| fromString "code"    
        
        
### Forward function application

Useful for avoiding parenthesis:

    scale 2 (move (10,10) (filled blue (ngon 5 30)))

    -- This can also be written as:
    
    ngon 5 30
      |> filled blue
      |> move (10,10)
      |> scale 2
    
## Signals - useful functions    


    Signal.map show Keyboard.awsd -- map the function show over the signal 
    show <~ Keyboard.awsd         -- same as above
    
    -- Signals have variations of map for multiple arguments. 
    -- For instance to map a binary function over two signals:
    Signal.map2 (,) Keyboard.wasd Keyboard.arrows
    
    -- ...which can be re-written like so
    (,) <~ Keyboard.wasd ~ Keyboard.arrows
    
