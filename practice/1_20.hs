--1. last element

myLast :: [a] -> a
myLast [x] = x
myLast (h:t) = myLast t

--2. length
myLength ::(Num b) => [a] -> b
myLength [] = 0
myLength (h:t) = 1 + myLength(t)

--3. last but one

myButLast :: [a] -> a
myButLast (h:t)
		|myLength t == 1	= h
		|myLength t > 1		= myButLast t

myButLast' [x,_] = x
myButLast' (h:t) = myButLast' t

myButLast'' (x:(_:[])) = x
myButLast'' (_:t) = myButLast'' t

--4. Kth element
kthElem :: (Num b, Ord b) => b -> [a] -> a
kthElem 1 (h:t) = h
kthElem k (_:t) = kthElem (k-1) t

--5. flatten
--data NestedList a = Elem a | List [NestedList a]
--flatten :: NestedList a -> [b]
--flatten (Elem x) = [x]
--flatten (List (h:t)) = flatten t ++ flatten (List t)

--8.
contains :: (Eq a) => [a] -> a -> Bool
contains [] _ = False
contains (x:xs) y 
	| x == y 	= True
	| x /= y	= contains(xs) y

--7.
intersect :: (Eq a) => [a] -> [a] -> [a]
intersect _ [] = []
intersect [] _ = []
intersect xs (y:ys)
	| elem y xs		= [y] ++ (intersect xs ys)
	| otherwise		= intersect xs ys

data T = T {func1 :: String, func2 :: String} deriving (Show, Read)

--func :: [a] -> [a] -> [a]
func :: (Num a) =>	 [a] -> a -> [a]
func [] _ = []
func ys x = map (+x) ys

--let test2 = (T "A" "B")

e x = let p = (1, 'p')
	in map(\y -> (1,'2'):y) x

gather :: [[Integer]] -> [[Integer]]
gather x = (foldr (\[a,b,c] y-> a:y) [] x) : (foldr (\[a,b,c] y-> b:y) [] x) : (foldr (\[a,b,c] y-> c:y) [] x) : []

getK :: Int -> [a] -> a
getK k l = head(drop (k-1) l) 

removeOdds [] y = y
removeOdds (x:xs) y = if x `mod` 2 == 0 then removeOdds xs (x:y) else removeOdds xs y


{-
	Daca am doua Or-uri cu mai multe And-uri de forma: 
	Or1 ( [a1] [a2] [a3] ) 
	Or2 ( [a1'] [a2'] [a3'] ) si fac intersectie
	vine Or ( ([a1] n [a1']) u ([a1] n [a2']) u ([a1] n [a3']) u ([a2] n [a1']) ...) ?

	Or1 ( [a1] [a2] [a3] )
	Or2 ( [b] )
	intersectie : Or ( ([a1] n [b]) u ([a2] n [b]) u ([a3] n [b]))

	si semnul de reuniune 'u' inseama ca toate sunt in aceeasi lista [And] ?
-}