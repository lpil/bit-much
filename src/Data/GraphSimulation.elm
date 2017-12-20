module Data.GraphSimulation
    exposing
        ( GraphSimulation
        , GraphAndSimulation
        , new
        , tick
        )

import Visualization.Force as Force
import Graph exposing (Graph, NodeId, NodeContext)
import Data.TransactionGraph exposing (TransactionGraph)
import Data.Entity exposing (Entity)
import RemoveMe exposing (..)


type alias GraphSimulation =
    Force.State NodeId


new : Graph a b -> GraphSimulation
new graph =
    let
        link { from, to } =
            ( from, to )

        linkForces =
            Graph.edges graph
                |> List.map link
                |> Force.links

        bodyForces =
            Graph.nodes graph
                |> List.map .id
                |> Force.manyBody

        centeringForce =
            Force.center (screenWidth / 2) (screenHeight / 2)
    in
        Force.simulation
            [ linkForces
            , bodyForces
            , centeringForce
            ]


type alias GraphAndSimulation rest =
    { rest
        | graph : TransactionGraph
        , simulation : GraphSimulation
    }


tick : GraphAndSimulation r -> GraphAndSimulation r
tick data =
    let
        ( newSimulation, list ) =
            Graph.nodes data.graph
                |> List.map .label
                |> Force.tick data.simulation
    in
        { data
            | graph = updateGraphWithList data.graph list
            , simulation = newSimulation
        }


updateContextWithValue : NodeContext Entity () -> Entity -> NodeContext Entity ()
updateContextWithValue nodeCtx value =
    let
        node =
            nodeCtx.node
    in
        { nodeCtx | node = { node | label = value } }


updateGraphWithList : Graph Entity () -> List Entity -> Graph Entity ()
updateGraphWithList =
    let
        graphUpdater value =
            Maybe.map (\ctx -> updateContextWithValue ctx value)
    in
        List.foldr (\node graph -> Graph.update node.id (graphUpdater node) graph)
