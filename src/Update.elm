module Update exposing (Msg(..), update)

import Model exposing (..)
import Data.Transaction


type Msg
    = Frame String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Frame message ->
            noEffect (handleFrame model message)


noEffect : Model -> ( Model, Cmd Msg )
noEffect model =
    model ! []


handleFrame : Model -> String -> Model
handleFrame model message =
    let
        bitcoin =
            Data.Transaction.decodeString message

        _ =
            Debug.log "transaction" bitcoin
    in
        { model
            | messages = model.messages
        }
