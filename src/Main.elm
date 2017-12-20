-- init : ( Model, Cmd Msg )
-- init =
--     let
--         model =
--             { messages = []
--             }
--     in
--         model ! effects
-- subscriptions : Model -> Sub Msg


module Main exposing (main)

import Html
import WebSocket
import AnimationFrame
import Visualization.Force as Force
import View
import Model exposing (..)
import Update exposing (Msg(..))
import Data.TransactionGraph
import Data.GraphSimulation


init : ( Model, Cmd Msg )
init =
    let
        graph =
            Data.TransactionGraph.empty

        model =
            { graph = graph
            , simulation = Data.GraphSimulation.new graph
            }

        effects =
            [ WebSocket.send "wss://ws.blockchain.info/inv"
                """{"op":"unconfirmed_sub"}"""
            ]
    in
        model ! effects


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        bitcoinTransactions =
            WebSocket.listen "wss://ws.blockchain.info/inv" NewTransaction

        renderTicks =
            -- Pause animation if the graph simulation has stablised
            if Force.isCompleted model.simulation then
                Sub.none
            else
                AnimationFrame.times Tick
    in
        Sub.batch
            [ bitcoinTransactions
            , renderTicks
            ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        }
