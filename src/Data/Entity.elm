module Data.Entity
    exposing
        ( Entity
        )

import Visualization.Force as Force
import Graph


type alias Entity =
    Force.Entity Graph.NodeId { value : String }
