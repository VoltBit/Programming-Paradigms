module NetworkData where
-- The possible values for a header field.
-- Null represents an impossible value (i.e. due to a constraint not being satisfied)
-- It is not mandatory to use Null

-- DO NOT CHANGE HOW Eq, Show and Read are implemented for this data type.
data Value = Any | Val String | Null  deriving (Show, Read, Eq)

-- A packet header will contain a fixed number of header fields which is known in advance.
-- Their type will be String. Header fields that will be used for representing packets will be: "Src", "Dst", "Port" 
-- [try to avoid using hardcoded values in flow operations' implementation]

type Header = String

-- Every header will be present in every flow bound to a value (see above).
-- This is represented by an Assignment

-- DO NOT CHANGE HOW Eq, Show and Read are implemented for this data type.
data Assignment = Eq Header Value | Null_asg deriving (Show, Read, Eq)

--TODO - define the datatype Flow
-- A Flow is represented by the following grammar:
--   <flow> ::= <constraint> | <constraint> or <flow>
--   <constraint> ::=   Src = <value> and Dst = <value> and Port = <value>
--   <value> is designated by the ADT Value, defined above

-- the above grammar is not rigid. You can design your implementation in any way you like. 
-- What is important to consider for your implementation is that each constraint explicitly 
-- specifies the values of all header-fields.

--f1 = read ("Flow (Or [And [Eq \"Src\" (Val \"a\"),Eq \"Dst\" Any,Eq \"Port\" Any]])") :: Flow
-- Flow ( Or [And [Eq ]])
-- [hint see tests]
--data Flow = {--[...] |--} VoidFlow deriving (Show, Read) 
--data Op = Op Assignment Assignment Assignment deriving (Show, Read)
--data Op = Or [Assignment] | And [Assignment] deriving(Show, Read)
data And = And [Assignment] deriving(Show, Read, Eq)
data Or = Or [And] deriving(Show, Read, Eq)
data Flow = Flow Or | VoidFlow deriving (Show, Read) 

getOr :: Flow -> Or
getOr (Flow x) = x

getAnds :: Or -> [And]
getAnds (Or x) = x

getAssignments :: And -> [Assignment]
getAssignments (And x) = x

getValue :: Assignment -> Value
getValue Null_asg = Null
getValue (Eq _ y) = y

getHeader :: Assignment -> Header
getHeader Null_asg = []
getHeader (Eq x _) = x

--Intersection:
--------------------------------------------------------------------
{- How it works: each [Assignment] from the first flow is intersected with each [Assignment] 
	of the second flow creating a structure  of type [[[Assignment]]] or [[And]].-}
cmpF :: Assignment -> Assignment -> Assignment
cmpF x y
	| x == Null_asg && y == Null_asg				= Null_asg
	| x == Null_asg									= y
	| y == Null_asg									= x
	| (getValue x) == (getValue y)					= x
	| (getValue x) == Any && (getValue y) /= Any	= y
	| (getValue x) /= Any && (getValue y) == Any	= x
	| (getValue x) /= (getValue y)					= Null_asg

assgnInt :: [Assignment] -> [Assignment] -> [Assignment]
assgnInt _ [] = []
assgnInt [] _ = []
assgnInt xs ys = zipWith cmpF xs ys

andMap f [] = []
andMap f (x:xs) = (And (f (getAssignments x)) : (andMap f xs))

funcTest :: [And] -> And -> [And]
funcTest [] _ = []
funcTest ys x = andMap(assgnInt (getAssignments x)) ys

--isValidAssignAssign :: [Assignment] -> Bool
isValidAssign [] = False
isValidAssign [a,b,c]
	| a == Null_asg		= False
	| b == Null_asg 	= False
	| c == Null_asg		= False
	| otherwise 		= True

--isValidAnd :: [And] -> Bool
isValidAnd [] = False
isValidAnd (x:xs)
	| isValidAssign (getAssignments x) && xs /= []	= isValidAnd xs
	| isValidAssign (getAssignments x) && xs == []	= True
	| not (isValidAssign (getAssignments x))		= False

flowFlatten :: [[And]] -> [And]
flowFlatten [] = []
flowFlatten x = foldr (++) [] x
--andIntersect' :: [And] -> [And] -> [And]
andIntersect' :: [And] -> [And] -> [And]
andIntersect' _ [] = []
andIntersect' [] _ = [] 
andIntersect' xs ys = removeNulls (flowFlatten ( map(funcTest xs) ys )) []
--andIntersect' xs ys = foldr (\x y -> if not ( elem Null_asg (getAssignments x)) then y ++ x else y) [] (map(funcTest xs) ys )

andIntersect :: [And] -> [And] -> [And]
andIntersect _ [] = []
andIntersect [] _ = []
andIntersect xs (y:ys)
	| elem y xs		= [y] ++ (andIntersect xs ys)
	| otherwise 	= (andIntersect xs ys)

removeNulls [] y = y
removeNulls (x:xs) y = if (isValidAssign (getAssignments x)) then removeNulls xs (x:y) else removeNulls xs y

orIntersect :: Or -> Or -> Or
orIntersect a b = (Or  (foldl (flip (:)) [] (andIntersect' (getAnds a) (getAnds b))))

-------------------------------------------------------------------- End of intersection code

--Subset
--------------------------------------------------------------------
-- receives two lists of Ands (Asignments), compares every Assignment in x with
-- every Assignment in y by mapping using subsetFunc
{-  How it works: it takes two lists on Ands (from two Flows) and checks every [Assignemnts] list of the
	first Flow with the [Assignments] lists of the second flow creating a coresponding list of bools for each
	comparison. If the first flow is graeter than the second then every list of lists containg triplets are
	checked for a True triplet -[True,True,True]. If there is no such triplet then one of the constraitns from 
	the first flow could not find a corresponding constraint in the second one.-}
cmpSubset :: Assignment -> Assignment -> Bool
cmpSubset x y
	| x == Null_asg && y == Null_asg				= False
	| x == Null_asg									= False
	| y == Null_asg									= False
	| (getValue x) == (getValue y)					= True
	| (getValue x) == Any && (getValue y) /= Any	= True
	| (getValue x) /= Any && (getValue y) == Any	= False
	| (getValue x) /= (getValue y)					= False

assgnIntSubset :: [Assignment] -> [Assignment] -> [Bool]
assgnIntSubset _ [] = []
assgnIntSubset [] _ = []
assgnIntSubset xs ys = zipWith cmpSubset xs ys

mapSubset f [] = []
mapSubset f (x:xs) = (f (getAssignments x)) : (mapSubset f xs)

--boolFlatten :: [[Bool]] -> [Bool]
boolFlatten a = foldr (++) [] a

mergeSubset :: [And] -> And -> [[Bool]]
mergeSubset [] _ = []
mergeSubset ys x = mapSubset(assgnIntSubset (getAssignments x)) ys

checkSubset :: [And] -> [And] -> [[[Bool]]]
checkSubset _ [] = [[[False,False,False]]]
checkSubset [] _ = [[[True,True,True]]]
checkSubset xs ys = map (mergeSubset xs) ys

getK :: Int -> [a] -> a
getK k l = head(drop (k-1) l) 

seekTruth :: [[Bool]] -> Bool
seekTruth x = elem [True,True,True] x

testFunc x y k = if k == 0 then True 
	else if [True,True,True] == (getK k (boolFlatten (checkSubset (getAnds x) (getAnds y)))) then
	testFunc x y (k-1) else False

orSubset :: Or -> Or -> Bool
orSubset x y
	| (length (getAnds x)) <= (length (getAnds y))		= elem True (map seekTruth (checkSubset (getAnds x) (getAnds y)))
	| otherwise											= testFunc x y (length (getAnds x))

-------------------------------------------------------------------- End of subset code

--Rewrite
--------------------------------------------------------------------

getNth :: Int -> [Assignment] -> Assignment
getNth _ [] = Null_asg
getNth n (x:xs) = if (n == 1) then x else (getNth (n-1) xs)

reAssign :: Assignment -> [Assignment] -> [Assignment]
reAssign Null_asg x = x
reAssign asg x
	| (getHeader asg) == "Src"		= [asg, (getNth 1 x), (getNth 3 x)]
	| (getHeader asg) == "Dst"		= [(getNth 1 x), asg, (getNth 3 x)]
	| (getHeader asg) == "Port"		= [(getNth 1 x), (getNth 2 x), asg]

doRewrite :: Assignment -> Flow -> Flow
doRewrite asg f = (Flow ( Or (map (\z -> (And (reAssign asg (getAssignments z)))) (getAnds ( getOr f))) ))

-------------------------------------------------------------------- End of rewrite code


f1 = read ("Flow (Or [And [Eq \"Src\" (Val \"a\"),Eq \"Dst\" Any,Eq \"Port\" Any]])") :: Flow
f2 = read ("Flow (Or [And [Eq \"Src\" (Val \"a\"),Eq \"Dst\" (Val \"a\"),Eq \"Port\" Any]])") :: Flow
f3 = read ("Flow (Or [And [Eq \"Src\" Any,Eq \"Dst\" (Val \"c\"),Eq \"Port\" Any]])") :: Flow
ff2 = read ("Flow (Or [And [Eq \"Src\" (Val \"a\"),Eq \"Dst\" Any,Eq \"Port\" Any],And [Eq \"Src\" (Val \"b\"),Eq \"Dst\" Any,Eq \"Port\" Any]])") :: Flow
ff3 = read ("Flow (Or [And [Eq \"Src\" Any,Eq \"Dst\" (Val \"c\"),Eq \"Port\" Any],And [Eq \"Src\" (Val \"a\"),Eq \"Dst\" Any,Eq \"Port\" Any]])") :: Flow
ff4 = read ("Flow (Or [And [Eq \"Src\" (Val \"a\"),Eq \"Dst\" Any,Eq \"Port\" Any],And [Eq \"Src\" (Val \"b\"),Eq \"Dst\" Any,Eq \"Port\" Any],And [Eq \"Src\" Any,Eq \"Dst\" (Val \"c\"),Eq \"Port\" Any]])") :: Flow
ff5 = read ("Flow (Or [And [Eq \"Src\" (Val \"a\"),Eq \"Dst\" Any,Eq \"Port\" Any],And [Eq \"Src\" Any,Eq \"Dst\" (Val \"c\"),Eq \"Port\" Any],And [Eq \"Src\" (Val \"e\"),Eq \"Dst\" (Val \"d\"),Eq \"Port\" Any]])") :: Flow
mostGeneralF = read ("Flow (Or [And [Eq \"Src\" Any,Eq \"Dst\" Any,Eq \"Port\" Any]])" ) :: Flow

-- Type class to which Flow must be enrolled.
-- It defines the three major operations that one must be able to perform on flows.
class FlowLike a where
	intersect :: a -> a -> a
	subset :: a -> a -> Bool
	rewrite :: Assignment -> a -> a