module Golf where

skipHelper :: Int -> Int -> Int -> [a] -> [a]
skipHelper _ _ _ [] = []
skipHelper start cur modLimit l
  | cur == modLimit  = (head l) : (skipHelper start start modLimit (tail l))
  | otherwise        = skipHelper start (cur + 1) modLimit (tail l)

skipHelper2 :: Int -> [a] -> [Int]
skipHelper2 _ [] = []
skipHelper2 cur l = cur : skipHelper2 (cur+1) (tail l) 


skips [] = []
skips [e] = [[e]]
skips l = map (\e -> skipHelper 1 1 e l) (skipHelper2 1 l)


localMaxima :: [Integer] -> [Integer]
localMaxima [] = []
localMaxima (x:y:[]) = []
localMaxima (x:y:z:xs)
  | (y > x) && (y > z)   = y : localMaxima (y:z:xs)
  | otherwise            = localMaxima (y:z:xs)
