module Flow where

import NetworkData

instance FlowLike Flow where 
	
	-- Intersection of two constraints should be performed for each pair of corresponding headers.
	-- For example for two simple Flows: 
	-- i.e. Flow $ Or $ [And [Eq "Src" (Val "A"), Eq "Dst" ANY, Eq "Port" ANY]] intersect
	-- 		Flow $ Or $ [And [Eq "Src" ANY, Eq "Dst" (Val "B"), Eq "Port" ANY]] ->
	-- Flow $ Or $ [And [Eq "Src" "A", Eq "Dst" (Val "B"), Eq "Port" ANY]]

	-- where expr $ expr' will be interpreted as expr (expr'). In words, $ opens a parenthesis where it occurs and 
	-- closes it at the end of the line

	-- Intersection with the VoidFlow is VoidFlow
	-- Atention! Intersection of Flows works the same as the intersection of math sets 
	-- [ here the sets would be the sets containing the constraints corresponding to every flow ]
	-- Check this out if confused: http://en.wikipedia.org/wiki/Union_(set_theory)#Union_and_intersection
	-- TODO intersect function
	--intersect :: Flow -> Flow -> Flow

	intersect VoidFlow _ = VoidFlow
	intersect _ VoidFlow = VoidFlow
	intersect a b = (Flow (orIntersect (getOr a) (getOr b)))

	-- Check if Flow a is subset of flow b
	-- VoidFlow is subset of any Flow
	-- Nothing is subset of VoidFlow (except from VoidFlow)

	-- A Flow is a subset of another if all its constraints have a corresponding constraint in the
	-- second flow to which they are a subset of.

	-- The subset check for two constraints works as in the case of intersect - the check
	-- should be applied in sequence for every corresponding header pairs in the two constraints

	-- check TestFlow - ff3 is subset of ff5 - because for every constraint from ff3 ( first and second )
	-- you can find another constraint in the second flow ff5:
	-- the first constraint of ff3 is subset of the second constraint of ff5
	-- and the second constraint of ff3 is subset of the first constraint of ff5

	-- TODO subset function
	subset VoidFlow VoidFlow = True
	subset VoidFlow x = True
	subset x VoidFlow = False
	subset x y = orSubset ( getOr x ) ( getOr y )

	-- Rewrite a header value to all components of Flow
	-- This does nothing to the VoidFlow.
	-- TODO rewrite function
	rewrite asg f
		| f == VoidFlow		= VoidFlow
		| otherwise			= doRewrite asg f

-- TODO - Flow as instance of Eq
-- Two flow are equal when they represent the same set of constraints.
-- Hint: You should implement this after the above functions were implemented and use them.
instance (Eq Flow) where
	VoidFlow == VoidFlow = True
	--x == y = (subset (intersect x y) x ) && (subset (intersect x y) y)
	x == y = (subset x y) && (subset y x)