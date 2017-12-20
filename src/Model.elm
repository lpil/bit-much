module Model exposing (..)

import Visualization.Force as Force
import Data.TransactionGraph exposing (TransactionGraph)
import Data.Entity exposing (Entity)
import Graph exposing (Edge, Graph, Node, NodeContext, NodeId)
import Data.GraphSimulation exposing (GraphSimulation)


type alias Model =
    { graph : TransactionGraph
    , simulation : GraphSimulation
    }
