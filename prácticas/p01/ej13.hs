module Ej13 where

data AB a = Nil | Bin (AB a) a (AB a) deriving(Show)

foldAB ::
    b                       -- Nil
    -> (b -> a -> b -> b)   -- Bin
    -> AB a
    -> b

foldAB z f x = case x of
    Nil -> z
    (Bin l v r) -> f (rec l) v (rec r)
    where rec = foldAB z f

-- foldAB z f Nil = z
-- foldAB z f (Bin l v r) = f (foldAB z f l) v (foldAB z f r)

recAB ::
    b                                       -- Nil
    -> (AB a -> a -> AB a -> b -> b -> b)   -- Bin
    -> AB a
    -> b

recAB z f x = case x of
    Nil -> z
    (Bin l v r) -> f l v r (rec l) (rec r)
    where rec = recAB z f

esNil :: AB a -> Bool
esNil x = case x of
    Nil -> True
    _ -> False

altura :: AB a -> Integer
altura = foldAB 0 (\rl v rr -> 1 + max rl rr)

cantNodos :: AB a -> Integer
cantNodos = foldAB 0 (\rl v rr -> 1 + rl + rr)

-- Preguntar
mejorSegún :: (a -> a -> Bool) -> AB a -> a
mejorSegún f (Bin l v r) = foldAB v (\rl v rr -> (rl `g` v) `g` rr) (Bin l v r)
    where g x y = if f x y then x else y

-- Preguntar
esABB :: Ord a => AB a -> Bool
esABB = recAB True f
    where
        f l v r rl rr
            | esNil l && esNil r = True
            | esNil r = rl && raíz l <= v
            | esNil l = rr && v < raíz r
            | otherwise = rl && rr && raíz l <= v && v < raíz r

raíz :: AB a -> a
raíz (Bin l v r) = v
