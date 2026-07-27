# More Polymorphism and Type Classes

- Haskell's polymorphism is known as *parametric polymorphism*
    - **parametric polymorphism**: polymorphic functions must work *uniformly* for any input type

## Parametericity
Let's take a look at the following function:
``` Haskell
f :: a -> a -> a
f x y = x && y
```
The compiler will complain, saying that `a` is a rigid type variable bound by the
type signature (f :: a -> a -> a). What does this mean?
    1. `a` is a **type variable**; it can stand in for any type
    2. the CALLER of the function gets to choose what the type of `a` gets to be, not the IMPLEMENTOR 
    3.  
