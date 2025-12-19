# 01-Intro
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

