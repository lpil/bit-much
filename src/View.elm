module View
    exposing
        ( view
        )

-- import Html exposing (..)

import RemoveMe exposing (..)
import Svg exposing (..)
import Svg.Attributes as Attr exposing (..)
import Model exposing (..)
import Update exposing (Msg(..))
import Visualization.Force as Force exposing (State)
import Graph exposing (Graph, Node, Edge)
import Data.Entity exposing (Entity)


view : Model -> Svg Msg
view model =
    svg
        [ width (toString screenWidth ++ "px")
        , height (toString screenHeight ++ "px")
        ]
        [ g
            [ class "links" ]
            (List.map (linkView model.graph) (Graph.edges model.graph))
        , g
            [ class "nodes" ]
            (List.map nodeView (Graph.nodes model.graph))
        ]


linkView : Graph Entity () -> Edge () -> Svg Msg
linkView graph edge =
    let
        source =
            graph
                |> Graph.get edge.from
                |> Maybe.map (.node >> .label)
                |> Maybe.withDefault (Force.entity 0 "")

        target =
            graph
                |> Graph.get edge.to
                |> Maybe.map (.node >> .label)
                |> Maybe.withDefault (Force.entity 0 "")
    in
        line
            [ strokeWidth "1"
            , stroke "#aaa"
            , x1 (toString source.x)
            , y1 (toString source.y)
            , x2 (toString target.x)
            , y2 (toString target.y)
            ]
            []


nodeView : Node Entity -> Svg Msg
nodeView node =
    circle
        [ r "2.5"
        , fill "#000"
        , stroke "transparent"
        , strokeWidth "7px"
        , cx (toString node.label.x)
        , cy (toString node.label.y)
        ]
        [ Svg.title [] [ text node.label.value ]
        ]
