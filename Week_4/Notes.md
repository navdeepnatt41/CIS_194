# higher-order programming and type inference
## anonymous functions
lambda abstractions allow us to avoid having to manually define one time functions
``` haskell
greaterthan100 :: [integer] -> [integer]
greaterthan100 l = filter (\e -> e > 100) l
```
we can even use something called an *operator section* to avoid explicit lambdas
``` haskell
greaterthan100_3 :: [integer] -> [integer]
greaterthan100_3 l = filter (>100) l
```
"now hold on" i hear you say....'>100' only has one argument. yes, it does - that's because it's a partially applied function! the other argument is an element from the list!
## function composition
``` haskell
foo :: (b -> c) -> (a -> b) -> (a -> c)
foo f g = \x -> f (g x)
```
What i just wrote is called **function compositon**. This mirrors what we've seen in math -> `f(g(x))` or `f ∘ g`

Haskell has a dedicated operator for function composition - `.` This is useful for our `wholemeal` style. For example:
``` Haskell
myTest :: [Integer] -> Bool
myTest xs = even (length (greaterThan100 xs))
```
becomes
``` Haskell
myTest :: [Integer] -> Bool
myTest = even . length . greaterThan100
```
Read right to left, this reads like a pipeline!

If we observe the type of `.`, we would find the following:
```
. :: (b -> c) -> (a -> b) -> a -> c
```
This seems odd - foo ouputs a function of type (a -> c). What gives?
## Currying and partial application
All functions in Haskell are *really* functions that only take one argument. That means that every function is really just taking partially applied functions. So...
``` Haskell
f :: Int -> Int -> Int
f x y = x*2 + y
``` 
is actually just 
``` Haskell
f :: Int -> (Int -> Int)
f x y = 2 * x + y
```
Functions arrows associcate to the right, which means that something like `A->B->C->D` is really just `A->(B->(C->D))`. We may always add or remove parentheses around the rightmost top-level arrow in a type.

Function application is left associative - that is, `f 3 2` is just `(f 3) 2`. This lines up with the type signature; `(f 3)` is of type `Int->Int` and applying `2` to it makes it `Int->Int->Int`. In such a case, we simply do not the parentheses - thus, we get the clean syntaz of `f 3 2`. Thus, considering the `foo` we wrote above we may move `x` to the left of the `=`:
``` Haskell
comp :: (b -> c) -> (a -> b) -> a -> c
comp f g x = f (g x)
```
The idea of representing multi-argument functions as a series of partially applied single-argument functions has a term - ***currying***. We may also use it to represent functions that use pairs:
``` Haskell
f'' :: (Int, Int) -> Int
f'' (x, y) = 2*x + y
```
The standard library defines *curry* and *uncurry* to convert between the two representations of a two-argument function:
``` Haskell
curry :: ((a, b) -> c) -> a -> b -> c
curry f x y = f (x, y)

uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x, y) = f x y
```
### Partial Application
Essentially, taking functions of multiple arguments and applying only SOME inputs to it to return a partially applied function is a result of currying. 
### Wholemeal Programming
We can rewrite the following:
``` Haskell
foobar :: [Integer] -> Integer
foobar [] = 0
foobar (x:xs)
    | x > 3     = (7*x + 2) + foobar xs
    | otherwise = foobar xs
```
as:
``` Haskell
foobar' :: [Integer] -> Integer
foobar' = sum . map (\x -> 7*x + 2) . filter (>3)
```
We essentially identify the recursion patterns and write out the higer order functions to use - thus, we've created a 'pipeline'. This known as a *point-free style* and ALL functions can be written in this manner....though, not ALL functions SHOULD be written in it. Just because you can, doesn't mean you should!
## Folds
Let's now define fold:
``` Haskell
fold :: b -> (a -> b -> b) -> [a] -> b
fold z f [] = z
fold z f (x:xs) = f x (fold z f xs)
``` 
The fold we've defined above is defined as `foldr` in the Prelude (with different arguments of course). There is also an equivalent `foldl` which folds to the left. Let's explore:
``` Haskell
foldr f z [a, b, c] = a `f` (b `f` (c `f` z))

foldl f z [a, b, c] = ((z `f` a) `f` b) `f` c
```
Always use `foldl'` from Data.List though, I'm not sure why but just do it :/