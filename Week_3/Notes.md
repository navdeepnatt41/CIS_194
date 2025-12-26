# Recursion patterns, polymorphism, and the Prelude
- Certain recursion patterns occur frequently and can thus be abstracted out
- By abstracting these patterns out, we can think about problems at a higher level - such is the goal of *wholemeal programming*
## Recursion patterns
- We start with a simple IntList
``` Haskell
data IntList = Empty | Cons Int IntList
```
- We might want to do some operations on this list, such as:
  - Perform an operation on every element of the list
  - Keep only some of the elements and throw away the others
