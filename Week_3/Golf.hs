module Golf where

-- skips
-- Fundamentally, this function is filtering elements based on index

skipHelper :: Int -> [a] -> [a]
skipHelper n l = map fst $ filter (\(_, i) -> i `mod` n == 0) $ zip l [1..(length l)]

skips :: [a] -> [[a]]
skips l = map (`skipHelper` l) [1..length l]

-- localMaxima
localMaxima :: [Integer] -> [Integer]
localMaxima [] = []
localMaxima [x, y] = []
localMaxima (x:y:z:xs)
  | y > x && y > z   = y : localMaxima (y:z:xs)
  | otherwise            = localMaxima (y:z:xs)

-- histogram
countOccurrences :: Integer -> [Integer] -> (Integer, Int)
countOccurrences num nums = (num, length $ filter (== num) nums)

allOccurrences :: [Integer] -> [(Integer, Int)]
allOccurrences nums = map (`countOccurrences` nums) [0..9]

maxOcurrence :: [(Integer, Int)] -> Int
maxOcurrence = maximum . map snd

maxHelper :: [Integer] -> Int
maxHelper = maxOcurrence . allOccurrences

line :: [(Integer, Int)] -> Int -> String
line l n = map (\(_, i) -> if i >= n then '*' else ' ') l ++ ['\n']

histogramSetup :: [Integer] -> String
histogramSetup m = concatMap (line (allOccurrences m)) [(maxHelper m), (maxHelper m - 1)..1]

histogram :: [Integer] -> String
histogram m = histogramSetup m ++ "==========\n0123456789\n"