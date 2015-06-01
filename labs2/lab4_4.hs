-- arbore binar cu elemente de orice tip

data Tree a = Nil | Node (Tree a) a (Tree a) deriving Show
data Tree a = Nil | 
t = Node(Nil 1 Node ( Nil 3 Nil))

foldT :: ( a -> b -> a -> a ) -> a -> (Tree b) -> a
foldT op acc Nil = acc
foldT op acc (Node l k r) = op (foldT op acc l) k (foldT op acc r)

mapT : (a -> b) -> (Tree a) -> (Tree b)
mapT op t = foldT((\x y z -> Node x (op y) z ) Nil) t


zipTree :: (a -> a -> a) -> (Tree a) -> Tree(a) -> (Tree a)
zipWith op Nil t = Nil
zipWith op t Nil = Nil
zipWith op (Node st1 k1 dr1) (Node st2 k2 dr2) = Node (zipWith op st1 st2) (op k1 k2) (zipWith op1 dr1 dr2)
