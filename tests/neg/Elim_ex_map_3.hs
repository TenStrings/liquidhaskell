{-@ LIQUID "--no-termination" @-}

{-# LANGUAGE QuasiQuotes #-}

module Elim_ex_map_3 (prop) where

import LiquidHaskell

import Prelude hiding (map)

--------------------------------------------------------------------------
[lq| prop :: List Even -> List Even |]
prop = map ((+ 0) . (+ 1))
--------------------------------------------------------------------------

[lq| type Even = {v:Int | v mod 2 == 0 } |]

data List a = Nil | Cons a (List a)

map f Nil         = Nil
map f (Cons x xs) = Cons (f x) (map f xs)
