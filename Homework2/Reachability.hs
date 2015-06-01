module Reachability where

import Flow
import NetworkData
import NetworkRepresentation
import NetworkElements

-- Computes reachability from a source to a destination.
reachability :: Network -> String -> String -> [Flow]
-- TODO implementation of reachability algorithm
reachability network src dst = [VoidFlow]