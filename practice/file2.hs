--zipTogether :: [a] -> [b] -> [(a,b)]

zipTogether [] [] = []
zipTogether [] ys = []
zipTogether xs [] = []
zipTogether (x:xs) (y:ys) = (x,y) : zipTogether xs ys
zipTogether' :: [a] -> [b] -> [(a,b)]
zipTogether' [] [] = []
zipTogether' [] ys = []
zipTogether' xs [] = []
zipTogether' xs ys = (head xs, head ys) : (zipTogether' (tail xs) (tail ys))

rev :: [a] -> [a]
rev [] = []
rev (x:xs) = (rev xs) ++ [x]


myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f [] [] = []
myZipWith f [] ys = []
myZipWith f xs [] = []
myZipWith f (x:xs) (y:ys) = (f x y) : (myZipWith f xs ys)

myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f (x:xs) = (f x) : (myMap f xs)

palindrome :: (Eq a) => [a] -> Bool
palindrome a = ((rev a) == a)

--myFoldr :: (a -> b -> c) -> [a] -> [d]
myFoldr f x [] = x
myFoldr f accumulator (h:t) = f h (myFoldr f accumulator t)

myFoldl _ x [] = x
myFoldl f acc (h:t) = f (myFoldl f acc t) h