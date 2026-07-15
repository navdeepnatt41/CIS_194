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
data Tree a = Leaf | Node Integer (Tree a) a (Tree a)
  deriving (Show, Eq)
height :: Tree a -> Integer
height Leaf = -1
height n@(Node h _ _ _) = h

makeNode :: a -> Tree a -> Tree a -> Tree a
makeNode v left right = 
  Node (1 + max (height left) (height right)) left v right

insert :: a -> Tree a -> Tree a
insert v Leaf = Node 0 Leaf v Leaf
insert v t@(Node h left val right)
  | height left == height right    = makeNode val newL right
  | otherwise                      = makeNode val left newR
    where 
      newL = insert v left 
      newR = insert v right
 
foldTree :: [a] -> Tree a 
foldTree = foldr insert Leaf
 
-- Exercise 3: More folds!
xor :: [Bool] -> Bool
xor = foldr (/=) False

map' :: (a -> b) -> [a] -> [b]
map' f  = foldr ((:) . f) []

-- Optional Exercise: foldl in terms of foldr
myfoldl :: (b -> a -> b) -> b -> [a] -> b
myfoldl f z xs = foldr (\e acc v -> acc (f v e)) id xs z

-- Exercise 4: Finding primes 
ofForm :: Integer -> [Integer]
ofForm n = filter (<=n) $ [ x + y + 2*x*y | x <- [1..n], y <- [x..n]]

sieveSundaram :: Integer -> [Integer]
sieveSundaram n = map (\e -> 2*e + 1) $ filter (\e -> e `notElem` ofForm n) [1..n]