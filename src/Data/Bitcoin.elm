module Data.Bitcoin
    exposing
        ( Bitcoin
        , fromSatoshi
        )


type alias Bitcoin =
    Float


type alias Satoshi =
    Int


fromSatoshi : Satoshi -> Bitcoin
fromSatoshi s =
    toFloat s / 100000000
