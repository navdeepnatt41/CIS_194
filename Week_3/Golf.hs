module Golf where

-- skips

skipHelper :: Int -> Int -> Int -> [a] -> [a]
skipHelper _ _ _ [] = []
skipHelper start cur modLimit l
  | cur == modLimit  = head l : skipHelper start start modLimit (tail l)
  | otherwise        = skipHelper start (cur + 1) modLimit (tail l)

skipHelper2 :: Int -> [a] -> [Int]
skipHelper2 _ [] = []
skipHelper2 cur l = cur : skipHelper2 (cur+1) (tail l)


skips :: [a] -> [[a]]
skips [] = []
skips [e] = [[e]]
skips l = map (\e -> skipHelper 1 1 e l) (skipHelper2 1 l)

-- localMaxima

localMaxima :: [Integer] -> [Integer]
localMaxima [] = []
localMaxima [x, y] = []
localMaxima (x:y:z:xs)
  | y > x && y > z   = y : localMaxima (y:z:xs)
  | otherwise            = localMaxima (y:z:xs)

-- histogram

{- 
	Step 1: Count out the occurrences
	Step 2: Find the maximum count - that will be how many lines there are. For each line, 
	you print the respective stars for each number in that line.
	Step 2: Print the last lines
-}

countOccurrences :: Integer -> [Integer] -> (Integer, Int)
countOccurrences num nums = (num, length $ filter (== num) nums)

allOccurrences :: [Integer] -> [(Integer, Int)]
allOccurrences nums = map (`countOccurrences` nums) [0..9]

maxOcurrence :: [(Integer, Int)] -> Int
maxOcurrence = maximum . map snd

maxHelper :: [Integer] -> Int
maxHelper = maxOcurrence . allOccurrences

line :: [(Integer, Int)] -> Int -> String
line [] _ = "\n"
line ((a, b):xs) n
  | b >= n      = '*' : line xs n
  | otherwise           = ' ' : line xs n

histogramSetup :: [Integer] -> String
histogramSetup m = concatMap (line (allOccurrences m)) [(maxHelper m), (maxHelper m - 1)..1]

histogram :: [Integer] -> String
histogram m = histogramSetup m ++ "==========\n0123456789\n"