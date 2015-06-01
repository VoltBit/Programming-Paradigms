-- Polymorphic data types

-- map : ( a-> b) -> [a] -> [b]

data List a = Void | Cons a (List a) deriving Show

-- foldL ::( a -> b -> a) -> a -> (List b) -> a
-- foldR ::(

foldL op acc Void = acc
foldL op acc (Cons e l) = foldL op ( op acc e) l

foldR op acc Void = acc
foldR op acc (Cons e l) = op e (foldR op acc l)

map op Void = Void
map op (Cons e l) = Cons ((op e) (map op l))
