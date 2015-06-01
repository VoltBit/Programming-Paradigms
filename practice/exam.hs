fib 0 _ = []
fib a b = a : (fib b (a + b) )


getIt [] _ = undefined
getIt (x:xs) 1 = x
getIt (x:xs) n = getIt xs (n-1)

--magic (x:xs) 1 = 1
--magic (x:xs)


showNfib n = getIt(fib 1 1) n

--maptest x = map (\x->[]:x) x
pws 0 acc = acc
pws x acc = pws (x-1) ((x*x) : acc)
pws' n = map(\x->x*x) [1..n]

--nPws 0 _ = [0]
--nPws 1 _ = [1]
--nPws 1 n acc = acc
--nPws count n acc = nPws (count-1) (n + n) ((n*n):acc)	
--nPws 0 _ = []
nPws n r = r : (nPws n (n * r))
--nPws count n = nPws count-1

g x y = x + y
testf f xs = foldr f 0 xs

testrev xs acc = foldr (\x acc-> acc ++ [x]) acc xs

f x = whileSum x 0
	where
		whileSum x i
			| i < 10 = whileSum (x+i) (i+1)
			| otherwise = x

ftest1 k = [0..k]