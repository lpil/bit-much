module Data.Transaction
    exposing
        ( Transaction
        , decoder
        , decodeString
        )

{-| A single bitcoin Transaction from blockchain.info.
-}

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required)
import Data.Bitcoin as Bitcoin exposing (Bitcoin)


type alias Transaction =
    Bitcoin


decoder : Decoder Transaction
decoder =
    valueDecoder


{-| Extracts the total estimated value from a raw blockchain.info
Bitcoin transaction payload.
-}
valueDecoder : Decoder Bitcoin
valueDecoder =
    list (field "value" int)
        |> at [ "x", "out" ]
        |> map (List.sum >> Bitcoin.fromSatoshi)


decodeString : String -> Result String Bitcoin
decodeString =
    Json.Decode.decodeString decoder
