module HW4 where

-- Exercise 1: Wholemeal programming
fun1 :: [Integer] -> Integer
fun1 = product . map (`subtract` 2) . filter even

fun2 :: Integer -> Integer
fun2 = sum
    . filter even
    . takeWhile (/= 1)
    . iterate (\n -> if even n then n `div` 2 else 3*n + 1)

-- Exercise 2: Folding with trees
-- To be done...

-- Exercise 3: More folds!
xor :: [Bool] -> Bool
xor = foldr (/=) False

map' :: (a -> b) -> [a] -> [b]
map' f  = foldr ((:) . f) []

-- Optional Exercise: foldl in terms of foldr