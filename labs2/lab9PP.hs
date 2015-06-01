--1. Functie generatoare
build :: (a->a) -> a -> [a]
build f x = x : (build f (f x))

--2. Select
select :: (Num a, Ord a) => a -> [a] -> a
select e (x1:x2:xs) = if (abs(x1 - x2) < e) then x1 else (select e (x2:xs))

--3. sqrt aprox
sqrt_aprox e k = select e (build (sqrt_aprox e k))