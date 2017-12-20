module Data.TransactionGraph
    exposing
        ( TransactionGraph
        , empty
        )

{-| A graph of all payers and payees in the log of bitcoin
transactions.
-}

import Graph exposing (Edge, Graph, Node, NodeContext, NodeId)
import Data.Entity exposing (Entity)


type alias TransactionGraph =
    Graph Entity ()


empty : TransactionGraph
empty =
    Graph.empty



--                 |> Graph.insert
--                     { node = { label = Force.entity 1 "1", id = 1 }
--                     , incoming = IntDict.empty
--                     , outgoing = IntDict.empty
--                     }
--                 |> Graph.insert
--                     { node = { label = Force.entity 2 "2", id = 2 }
--                     , incoming = IntDict.singleton 1 ()
--                     , outgoing = IntDict.empty
--                     }
