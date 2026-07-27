{-# LANGUAGE TypeSynonymInstances #-}

module Week_5.Calc where

import Week_5.ExprT 
import Week_5.Parser 

-- Exercise 1
eval :: ExprT -> Integer
eval (Lit value) = value
eval (Add arg1 arg2) = (+) (eval arg1) (eval arg2)
eval (Mul arg1 arg2) = (*) (eval arg1) (eval arg2)

-- Exercise 2
evalStr :: String -> Maybe Integer 
evalStr expression = eval <$> parseExp Lit Add Mul expression

-- Exercise 3
class Expr a where
    lit :: Integer -> a
    add :: a -> a -> a 
    mul :: a -> a -> a

instance Expr ExprT where 
    lit = Lit 
    add = Add  
    mul = Mul 

-- Exercise 4 
instance Expr Integer where 
    lit = id 
    add = (+)
    mul = (*)

instance Expr Bool where 
    lit = (>0)
    add = (||)
    mul = (&&)

newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)

instance Expr MinMax where 
    lit = MinMax 
    add (MinMax v_a) (MinMax v_b) = MinMax (max v_a v_b) 
    mul (MinMax v_a) (MinMax v_b) = MinMax (min v_a v_b) 

instance Expr Mod7 where 
    lit = Mod7 . flip mod 7 
    add (Mod7 v_a) (Mod7 v_b) = lit (v_a + v_b)
    mul (Mod7 v_a) (Mod7 v_b) = lit (v_a * v_b)

data StackExp = PushI Integer
              | PushB Bool
              | AddS
              | MulS
              | And
              | Or
                deriving Show

type Program = [StackExp]

instance Expr Program where 
    lit n = [PushI n]
    
    add a b = a ++ b ++ [AddS]
    mul a b = a ++ b ++ [MulS]

eval2 :: ExprT -> Program
eval2 (Lit n) = lit n 
eval2 (Add a b) = add (eval2 a) (eval2 b)
eval2 (Mul a b) = mul (eval2 a) (eval2 b)

compile :: String -> Maybe Program 
compile = parseExp lit add mul 