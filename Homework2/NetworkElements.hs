module NetworkElements where

import NetworkRepresentation
import NetworkData
import Flow

--This file describes the language used for representing a network (also used in the tests)

-- Data type that represents the network devices

-- Wire - represents a network wire connecting two ports.
-- i.e. Wire "a" "b" -> The port "a" is connected to "b"

-- The Firewall device represents a set of filter conditions.
-- For instance [("Src", ["a"])] says the firewall is going to be 
-- traversed if and only is Src is bound to "a"
-- [(Src, ["a", "b"])] says the firewall is going to be 
-- traversed if and only if Src is bound to "a" OR "b"
-- [(Src, ["a", "b"]), (Dst, ["d"])] says the firewall is going to be 
-- traversed if and only if Src is bound to "a" OR "b" AND Dst is bound to "d"

-- The Proxy device performs a rewriting of a header value
-- Proxy (Eq "Dst" (Val "d")) - is a proxy that rewrites "Dst" value to d for every flow it processes
-- Proxy (Eq "Src" (Val "s")) - is a proxy that rewrites "Src" value to s for every flow it processes

-- The ComplexDevice is a list of Devices : Wire, Firewall and Proxy and performs 
-- the actions of the components
-- i.e. ComplexDevice[Wire "P" "R", Firewall [("Src", ["a","b"])], Proxy (Eq "Dst" (Val "d"))] -
-- the device connects ports "P" and "R", is going to be traversed if and only if Src is bound to 
-- "a" or "b" and will rewrite the "Dst" value to "d".
-- * it's assured that the rules of the components will not overlap.
data Device = Wire String String | Firewall [(Header, [String])] | Proxy Assignment | ComplexDevice [Device] deriving (Show, Read, Eq)

-- From such an device one should be able to produce a pair of match and modify rules.
instance Element Device where
	--TODO - implement get_rule for every Device constructor
	get_rule ( Wire src dst ) = (\x-> False, \x -> VoidFlow)
	--get_rule ( Wire src dst ) = (Wire )
	get_rule ( Firewall conditions ) = (\x-> False, \x -> VoidFlow)
	get_rule (Proxy (Eq h v)) = (\x-> False, \x -> VoidFlow)
	get_rule (ComplexDevice devices)  = (\x-> False, \x -> VoidFlow)