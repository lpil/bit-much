module View exposing (view)

import Html exposing (..)
import Model exposing (..)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    let
        item message =
            li [] [ text message ]
    in
        ol [] (List.map item model.messages)
