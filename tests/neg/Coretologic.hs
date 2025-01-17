module Coretologic where

import Data.Set

-- ISSUE: can we please allow things like `empty` to also
-- appear in type and alias specifications, not just in
-- measures as in `goo` below?

{-@ type IsEmp a = {v:[a] | listElts v = Data.Set.empty } @-}

{-@ foo :: IsEmp Int @-}
foo :: [Int]
foo = []

{-@ bar :: IsEmp Int @-}
bar :: [Int]
bar = [1]

{-@ measure goo @-}
goo        :: (Ord a) => [a] -> Set a
goo []     = empty
goo (x:xs) = (singleton x) `union` (goo xs)  
