--functions

getDouble x = x + x

getDoubleTwo x y = (x * 2, y * 2)

getDoubleFiltered x = if x > 50
			then x
			else x * 2

getDoubleFiltered' x = (if x > 50 then x else x * 2) + 100

rangeDodos xs = [ if x < 10 then "Hello" else "Nope" | x <- xs, odd x ]
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]   

-- types and typeclasses
filterChars :: [Char] -> [Char]
filterChars st = [ x | x <- st, x `elem` ['A'..'Z']]

