module Week_4.HW4 where
import Data.List (foldl')

fun1 :: [Integer] -> Integer
fun1 = product . map (`subtract` 2) . filter even 

fun2 :: Integer -> Integer
fun2 = foldl' (+) 0
    . filter even
    . takeWhile (/= 1)
    . iterate (\n -> if even n then n `div` 2 else 3*n + 1) 

data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
    deriving (Show, Eq)

foldTree :: [a] -> Tree a
foldTree [] = Leaf
foldTree [x] = Node 1 Leaf x Leaf