-- Tail Recursive Helper Function
toDigitsHelper :: Integer -> [Integer] -> [Integer]
toDigitsHelper 0 accum = accum
toDigitsHelper n accum = toDigitsHelper (n `div` 10) ((n `mod` 10) : accum)

toDigits :: Integer -> [Integer]
toDigits n = toDigitsHelper n []

toDigitsRev :: Integer -> [Integer]
toDigitsRev = reverse . toDigits 

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther (a:[]) = a : doubleEveryOther []
doubleEveryOther (a:b:rest) = a : (b*2) : doubleEveryOther rest

sumDigits :: [Integer] -> Integer
sumDigits = sum . concat . map toDigits

validate :: Integer -> Bool
validate n = mod (sumDigits $ doubleEveryOther $ toDigitsRev n) 10 == 0

type Peg = String
type Move = (Peg, Peg)
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 a b c = []
hanoi 1 a b c = [(a, c)]
hanoi 2 a b c = (a, b) : (a, c) : (b, c) : []
hanoi n a b c = (hanoi (n-1) a b c) : (a, b) : (hanoi (n-1) c a b)