generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs
    | stop xs = init xs
    | otherwise = generateFrom stop next (xs ++ [next xs])

generateBase :: ([a] -> Bool) -> a -> (a -> a) -> [a]
generateBase stop base next = generate stop (\xs -> if null xs then base else next (last xs))

factoriales :: Int -> [Int]
factoriales n = generate (\xs -> length xs > n) (\xs -> if null xs then 1 else last xs * (length xs + 1))

iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generateBase (\xs -> length xs > n) x f

-- Se rompe al generar la lista vacía.
generateFrom2 :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom2 stop next xs = last (takeWhile (not . stop) (iterate (\xs -> xs ++ [next xs]) xs))

-- stop = (\xs -> not (null xs) && (last xs > 10))
-- next = (\xs -> if null xs then 0 else last xs + 1)
-- generate stop next
-- generateFrom stop next []
-- generateBase stop 0 (+1)
