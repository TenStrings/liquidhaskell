module Vector2 () where

import Prelude hiding (length)
import Data.Vector
import Language.Haskell.Liquid.Prelude (liquidAssert)
    
{-@ predicate Lt X Y      = X < Y                         @-}
{-@ predicate Ge X Y      = not (Lt X Y)                  @-}
{-@ predicate InBound I A = ((Ge I 0) && (Lt I (vlen A))) @-}

{-@ unsafeLookup :: vec:Vector a 
                 -> {v: Int | (0 <= v && v < (vlen vec)) } 
                 -> a @-}
unsafeLookup vec i = vec ! i

{-@ unsafeLookup' :: vec:Vector a -> {v: Int | (InBound v vec)} -> a @-}
unsafeLookup' vec i = vec ! i

safeLookup x i 
  | 0 <= i && i < length x = Just (x ! i)
  | otherwise              = Nothing 

{-@ absoluteSum   :: Vector Int -> {v: Int | 0 <= v}  @-}
absoluteSum       :: Vector Int -> Int 
absoluteSum vec   = if 0 < n then go 0 0 else 0
  where
    go acc i 
      | i /= n    = go (acc + abz (vec ! i)) (i + 1)
      | otherwise = acc 
    n             = length vec

abz n = if 0 <= n then n else (0 - n) 

loop :: Int -> Int -> a -> (Int -> a -> a) -> a 
loop lo hi base f = go base lo
  where
    go acc i     
      | i /= hi   = go (f i acc) (i + 1)
      | otherwise = acc

incr x = x + 1

zoo = incr 29

{-@ dotProduct :: x:(Vector Int) 
               -> y:{v: Vector Int | (vlen x) = (vlen x)} 
               -> Int 
  @-}
dotProduct     :: Vector Int -> Vector Int -> Int
dotProduct x y 
  = loop 0 (length x) 0 (\index -> (+ (x ! index) * (y ! index))) 
  -- = error "dotProduct only on equal-sized vectors!"


{-@ type SparseVector a N = [({v: Int | (0 <= v && v <= N)}, a)] @-}

{-@ sparseDotProduct :: (Num a) => x:(Vector a) -> (SparseVector a {(vlen x)}) -> a @-}
sparseDotProduct x y  = go 0 y
  where 
    go sum ((i, v) : y') = go (sum + (x ! i) * v) y' 
    go sum []            = sum

jhala = vs ! (x + y + z)
  where x = 2
        y = 3
        z = 5
        vs = fromList [1,2,3,4] 
