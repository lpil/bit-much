module Update exposing (Msg(..), update)

import Model exposing (..)
import Time exposing (Time)
import Data.Transaction
import Data.Entity exposing (Entity)
import Data.GraphSimulation as GraphSimulation


type Msg
    = Tick Time
    | NewTransaction String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            noEffect (handleTick model)

        NewTransaction payload ->
            noEffect (handleNewTransaction payload model)


handleTick : Model -> Model
handleTick model =
    GraphSimulation.tick model


noEffect : Model -> ( Model, Cmd Msg )
noEffect model =
    model ! []


handleNewTransaction : String -> Model -> Model
handleNewTransaction payload model =
    let
        bitcoin =
            Data.Transaction.decodeString payload

        _ =
            Debug.log "transaction" bitcoin
    in
        model
