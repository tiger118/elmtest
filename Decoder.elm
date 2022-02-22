module Decoder exposing
    ( Decoder
    , Value
    , andThen
    , decode
    , field
    , map
    , map2
    , mapError
    , string
    , timePosix
    )

import Time


{-| If it helps, this can be moved out of the module and into DecoderTest itself
-}
type alias Value k =
    List ( k, String )


type Decoder x a
    = Decoder -- TODO: this variant is just a placeholder; replace this variant with your own


string =
    Debug.todo "string"


timePosix =
    Debug.todo "timePosix"


field =
    Debug.todo "field"


map =
    Debug.todo "map"


map2 =
    Debug.todo "map2"


mapError =
    Debug.todo "mapError"


andThen =
    Debug.todo "andThen"


decode =
    Debug.todo "decode"
