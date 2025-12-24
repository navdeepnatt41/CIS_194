## Enumeration Types
- Haskell has its own *enumeration* types
``` Haskell
data Thing = Shoe 
            | Ship
            | SealingWax
            | Cabbage
            | King
  deriving Show
-- Deriving Show generates code to convert `Things` to `Strings`
```
- We can pattern match on `Thing`s
``` Haskell
shoe :: Thing
shoe = Shoe

listO'Things :: [Thing]
listO'Things = [Shoe, SealingWax, King, Cabbage, King]

isSmall :: Thing -> Bool
isSmall Shoe       = True
isSmall Ship       = False
isSmall SealingWax = True
isSmall Cabbage    = True
isSmall King       = Flase
```
- We could also make the definition shorter via:
``` Haskell
isSmall Ship = False
isSmall King = False
isSmall _ = True
```
## Beyond Enums
- Enumerations are simply a special case of Haskell's more general **Algebraic Data Types**
### Example
``` Haskell
data FailableDouble = Failure | OK Double
  deriving Show
```
- In this example, there are two data constructors- `Failure` and `OK` 
  - `Ok` takes a `Double` as well
``` Haskell
ex01 = Failure
ex02 = OK 3.14
-- The Type of OK is `Double -> FailableDouble`

safeDiv :: Double -> Double -> FailableDouble
safeDiv _ 0 = Failure
safeDiv x y = OK (x / y)

failureToZero :: FailableDoube -> Double
failureToZero Failure = 0
failureToZero (OK d) = d
``` 
- Data constructors can have multiple arguments
``` Haskell
data Person = Person String Int Thing
  deriving Show

brent :: Person
brent = Person "Brent" 31 SealingWax

getAge :: Person  -> Int
getAge (Person _ a _)  = a
```
## Algebraic Data Types in General
- ADTS have 1 or more constructors, while each constructor can have 0 or more arguments
``` Haskell
data AlgDataType = Constr1 Type11 Type12
                 | Constr2 Type21
                 | Constr3 Type31 Type32 Type33
                 | Constr4 Type4
```
- Types must start with capital letters while variables must start with lowercase letters
## Pattern Matching
- Pattern matching is fundamentally about taking apart a value by *finding out which constructor* it was built with
- We can give names to the values that come with the constructors
``` Haskell
foo (Constr1 a b)   = ...
foo (Constr2 a)     = ...
foo (Constr3 a b c) = ...
foo Constr4         = ...
```
- `_` can serve as a wildcard to match against anything if we don't care about it
- `x@pat` can be used to pattern match, but also provide a name to the entire value being matched against
- patterns can also be nested as well
``` Haskell
baz :: Person -> String
baz p@(Person n _ _) = "The name field of (" ++ show p ++ ") is" ++ n

checkFav :: Person -> String
checkFav (Person n _ SealingWax) = n ++ ", you're my kind of person"
checkFav (Person n _ _)          = n ++ ", your favorite thing is lame."
```
- The follow grammar defines what can be used as a pattern 
  ``` 
  pat ::= _
        |  var
        |  var @ ( pat )
        |  ( Constructor pat1 pat2 ... patn)
  ```
## Case Expressions
- The fundamental construct for pattern matching in Haskell is the `case` expression
``` Haskell
case exp of 
  pat1 -> exp1
  pat2 -> exp2

ex03 = case "Hello" of
           []      -> 3
           ('H':s) -> length s
           _       -> 7 
```
- Really, the synatc for defining functions is just syntactic sugar for case expressions
## Recursive data types
- Data types can be *recursive*; lists are defined as such
``` Haskell
data IntList = Empty | Cons Int IntList

intListProd :: IntList -> Int
intListProd Empty      = 1
intListProd (Cons x l) = x * intListProd l

data Tree = Leaf
          | Node Tree Int Tree
    deriving Show
```

