module Main exposing (main)

import Html exposing (..)
import WebSocket
import Model exposing (..)
import Update exposing (Msg(..))
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    let
        effects =
            [ WebSocket.send "wss://ws.blockchain.info/inv"
                """{"op":"unconfirmed_sub"}"""
            ]

        model =
            { messages = []
            }
    in
        model ! effects


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "wss://ws.blockchain.info/inv" Frame
