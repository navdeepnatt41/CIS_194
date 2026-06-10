# Recursion patterns, polymorphism, and the Prelude
- Certain recursion patterns occur frequently and can thus be abstracted out
- By abstracting these patterns out, we can think about problems at a higher level - such is the goal of *wholemeal programming*
## Recursion patterns
- We start with a simple IntList
``` Haskell
data IntList = Empty | Cons Int IntList
```
We might want to do some operations on this list, such as:
- Perform an operation on every element of the list
- Keep only some of the elements and throw away the others
- "Summarize" the list
- and more!
### Map
Suppose we want to add 1 to each element
``` Haskell
absAll :: IntList -> IntList
absAll [] = []
absAll x:xs = (x + 1) : absAll xs
```
Or, we could ensure every element is non-negative
``` Haskell
absAll :: IntList -> IntList
absAll [] = []
absAll (Cons x xs) = Cons (abs x) (absAll xs)
```
Even square them:
``` Haskell
squareAll :: IntList -> IntList
squareAll [] = []
squareAll (Cons x xs) = Cons (x * x) (squareAll xs)
```
At this point, we realize the pattern - map
``` Haskell
map :: (A -> B) -> [A] -> [B]
map _ [] = []
map f (x:xs) = (f x) : (map f xs)
```
### Filter
I won't bother going through the examples, I'll just provide the "pattern"
``` Haskell
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x:xs) 
  | p x   = x : filter p xs
  | otherwise = filter p xs
```
### Fold
The way I would define it is like the following, but different types of folds exist. It's a bit naive but the core structural pattern is apparent.
``` Haskell
fold :: (a -> a -> a) -> a -> [a]
fold _ accum [] = e
fold p accum x:xs = fold p (accum `p` x) xs
```
## Polymorphism
So, we've abstracted general patterns - map and filter (even fold). However, there's no reason we NEED to define the patterns explictly for different types of data types. Luckily, Haskell supports *polymorphism* for both data types AND functions.
### Polymorphic data types
Here's how we define a polymorphic data type:
``` Haskell
data List t = E | C t (List t)
```
By using a **type variable** `t`, we've essentially *parameterized* List. Now, rather than needing to define something like `IntList` we can simply use `List Int`. Thus, we can do things like this:
``` Haskell
exl1 :: List Int
exl1 Int = C 1 (C 2 (C 3 E))

exl2 :: List Char
exl2 Char = C 'a' (C 'b' (C 'c' E))

ex3 :: List Bool
exl3 Bool = C 'True' (C 'False' E)
```
### Polymorphic Functions
We can now write something like this:
``` Haskell
filterList :: (t -> Bool) -> List t -> List t
filterList _ E = E
filterList p (C x xs)
  | p x       = C x (filterList p xs)
  | otherwise = filterList p xs
```
Also, since I'm a genius, I already wrote a pretty good map which I can use for mapList:
``` Haskell
mapList :: (a -> b) -> List a -> List b
mapList _ E = E
mapList p (C x xs) = C (p x) (mapList p xs)
```
## The Prelude
The **Prelude** is a module with a bunch of standard definitions that get implicitly imported into every Haskell program. It contains plenty of useful polymorphic functions.

Another useful polymorphic type to know of is `Maybe`, which is defined as:
``` Haskell
data Maybe = Nothing | Just a
```
## Total and partial functions
The `head` function as defined in the Prelude is called a *partial function* - that is, it is a function that isn't well defined for all possible cases. That means it can

CRASH

Thus, we should use *total functions* that ARE well defined.
### Replacing partial functions
Observe the following two functions:
``` Haskell
doStuff1 :: [Int] -> Int
doStuff1 [] = 0
doStuff1 [_] = 0
doStuff1 xs = head xs + (head (tail xs))

doStuff2 :: [Int] -> Int
doStuff2 [] = 0
doStuff2 [_] = 0
doStuff2 (x1:x2:_) = x1 + x2
```
doStuff2 *explicitly* handles all the possible cases that the list can adhere to - thus, it is well defined.
### Writing partial functions
We shall now implement a safe `head`
``` Haskell
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x
```
IMPORTANT - ALWAYS USE TOTAL FUNCTIONS. It's a good idea to reference the <u>safe</u> package in Haskell

