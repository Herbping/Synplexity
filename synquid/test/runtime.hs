main = putStrLn (show $ prod3 (1000000000000000000000000-1) (10000000000000000000000000-1))
dec x = x - 1
plus x y = x + y
double x = x + x
div2 x = quot x  2
evenf x = (x `mod`  2) == 0
prod1 x y = if x == 0 then x
            else plus y (prod1 (dec x) y) 
prod2 x y = if x == 0 then x else
                if even x 
                    then double (prod2 (div2 x) y)
                    else plus y (double (prod2 (div2 x) y))

prod3 x y = x * y
