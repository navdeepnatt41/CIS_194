# Haskell Basics

## What is Haskell?
- Haskell is a lazy, functional programming language
- Haskell is:
    - *functional*, which usally means:
        - Functions are *first class* - in that functions are values which can be used in exactly the same ways as any other sort of value
        - Haskell is centered around *evaluating expressions* over *executing instructions* 
    - *pure*
        - Haskell expressions are always *referentially transparent*
            - no mutation
            - no side effects
            - the same input with a function always gives the same output
    - There are benefits to this programming paradigm
        - Equational reasoning and refactoring
        - Parallelism
        - Fewer headaches
    - *lazy*: expressions are not evaluated until they are needed
        - you can define a new *control structure* just by defining a function
        - *infinite data structures* become possible
        - enables <u>compositional programming</u> style
        - Note that reasoning about time and space usage becomes hard with lazy evaluation
    - *Statically Typed* 

## Themes
- Focus will be on 3 things
    - Types
        - Haskell's type systems helps clarify thinking and express program structure
        - Self documentation
        - Turns run time errors into compile time errors (how based)
    - Abstraction
        - Makes "Don't Repeat Yourself" easy to implement; parametric polymorphism, higher-order functions, type classes
    - Wholemeal programming
        - Essentially, allows you to think of coding in "complete terms"

## Declarations and Variables
``` Haskell
x :: Int
x = 3

-- Single line comments
{- 
  Multi-line comments
-}
```
- Values are immutable; 3 is not being assigned to x, x is being *defined* as having the value of 3
``` Haskell
y :: Int
y = y + 1
-- This will result in infintie recursion~
```

## Basic Types
``` Haskell
-- Machine-sized integers
i :: Int
i = -78

-- Int has min/max bounds dependent on the machine. You can check the bounds by evaluating the following.
biggestInt, smallestInt :: Int
biggestInt = maxBound
smallestInt = minBound

-- Arbitrary precision integers
n :: Integer 
n = 1888888888888888888888888888888888 -- Only really limited by how much memory you've got

-- Double
d1 :: Double
d1 = 3.47

-- Booleans
truth, falsehoods :: Bool
truth = True
falsehoods = False

-- Unicode characters
c1, c2, c3 :: Char
c1 = 'x'
c2 = 'Ø'
c3 = 'ダ'

-- Strings are lists of characters with special syntax
s :: String
s = "Hello, Haskell"
```

## Arithmetic
- Typical operators that you would expect
- Backticks(``) allow you to make operators **infix**

## Boolean logic
- Basic equality operators, come on you KNOW this
- Also, there are if-expressions
    - if-expressions require an else clause which differs from if-statements

## Defining basic functions
- We can write functions that work based off of cases
``` Haskell
sumtorial :: Integer -> Integer
sumtorial 0 = 0
sumtorial n = n + sumtorial (n-1)
```
- Choices can also be made on arbitry Boolean guards using *guards*
``` Haskell
hailstone :: Integer -> Integer
hailstone n
  | n `mod` 2 == 0 = n `div` 2
  | otherwise      = 3*n + 1
```

## Pairs
- Pairs allow us to *pair* things together (heh)
``` Haskell
p :: (Int, Char)
p = (3, 'x')

-- The elements of a pair can be accessed with *pattern matching*
sumPair :: (Int, Int) -> Int
sumPair (x, y) = x + y
```

## Using functions and multiple arguments
- Just call the functions with the arguments passed in
- Function application has higher precedence than infix operators

## Lists
- Lists are a very basic data type in Haskell
- There are also list comprehensions
``` Haskell
nums, range, range2 :: [Integer]
nums   = [1,2,3,19]
range  = [1..100]
range2 = [2,4..100]
```

## Constructing Lists
``` Haskell
emptyList = []
ex18 = 1 : []
ex19 = 1 : 2 : 3 : 4 : []
ex20 = 1 : (2 : [])

hailstoneSeq :: Integer -> [Integer]
hailstoneSeq 1 = [1]
hailstoneSeq n = n : hailstoneSeq (hailstone n)

## Functions on Lists
- We can write functions on lists using pattern matching
``` Haskell
intListLength :: [Integer] -> Integer
intListLength [] = 0
intListLength (x:xs) = x + intListLength xs
-- Note we can use `_` instead of assigning a variable to the pattern if we don't need it

## Combining functions
- I'm not going to write the function, but don't be afraid; functions that you think might take up a lot more space
  actually may not due to lazy evaluation

## Don't Be Scared of Messages
