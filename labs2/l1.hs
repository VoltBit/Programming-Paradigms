module Main where
	factorial n = if n <= 0
		then 1
		else n * factorial(n - 1)

	factorial' 0 = 1
	factorial' n = n * factorial (n-1)




	fib 0 = 1
	fib 1 = 1
	fib n = fib (n-1) + fib (n-2)

	--tail recursive
	fib' n = 
