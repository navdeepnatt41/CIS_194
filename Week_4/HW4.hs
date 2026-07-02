module HW4 where

-- Exercise 1: Wholemeal programming
fun1 :: [Integer] -> Integer
fun1 = product . map (`subtract` 2) . filter even

fun2 :: Integer -> Integer
fun2 = foldl' (+) 0
    . filter even
    . takeWhile (/= 1)
    . iterate (\n -> if even n then n `div` 2 else 3*n + 1)

-- Exercise 2: Folding with trees
data Tree a = Leaf
    | Node Integer (Tree a) a (Tree a)
  deriving (Show, Eq)

getHeight :: Tree a -> Integer
getHeight Leaf = 0
getHeight n@(Node height _ _ _) = height

insert :: a -> Tree a -> Tree a
insert e Leaf = Node 0 Leaf e Leaf
insert e t@(Node height left elem right)
  | (getHeight left) > (getHeight right)    = Node (1 + max (getHeight (insert e right)) (getHeight left)) left elem (insert e right)
  | otherwise                               = Node (1 + max (getHeight (insert e left)) (getHeight right)) (insert e left) elem right

foldTree :: [a] -> Tree a
foldTree = foldr insert Leaf

-- Exercise 3: More folds!
xor :: [Bool] -> Bool
xor = foldr (/=) False

map' :: (a -> b) -> [a] -> [b]
map' f  = foldr ((:) . f) []

-- Optional: foldl through foldr
myFoldL :: (b -> a -> b) -> b -> [a] -> b
