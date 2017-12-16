module Data.Transaction exposing (decoder, decodeString)

{-| A single bitcoin Transaction from blockchain.info.
-}

import Json.Decode exposing (..)
import Data.Bitcoin as Bitcoin exposing (Bitcoin)


{-| Extracts the total estimated value from a raw blockchain.info
Bitcoin transaction payload.
-}
decoder : Decoder Bitcoin
decoder =
    list (field "value" int)
        |> at [ "x", "out" ]
        |> map (List.sum >> Bitcoin.fromSatoshi)


decodeString : String -> Result String Bitcoin
decodeString =
    Json.Decode.decodeString decoder
