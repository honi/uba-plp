mejorSegún :: (a -> a -> Bool) -> [a] -> a
mejorSegún f = foldr1 (\x y -> if f x y then x else y)

sumasParciales :: Num a => [a] -> [a]
sumasParciales = foldl (\r x -> r ++ (if null r then [x] else [x + last r])) []

sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

-- sumaAlt [1,2,3] = (1 - (2 - (3 - 0)))
-- sumaAlt [1,2,3] = (1 - (2 - 3 + 0))
-- sumaAlt [1,2,3] = (1 - 2 + 3 - 0)

-- sumaAlt [1,2,3,4] = (1 - (2 - (3 - (4 - 0))))
-- sumaAlt [1,2,3,4] = (1 - (2 - (3 - 4 + 0)))
-- sumaAlt [1,2,3,4] = (1 - (2 - 3 + 4 - 0))
-- sumaAlt [1,2,3,4] = (1 - 2 + 3 - 4 + 0)

sumaAlt2 :: Num a => [a] -> a
sumaAlt2 = foldl (flip (-)) 0

-- sumaAlt2 [1,2,3] = (3 - (2 - (1 - 0)))
-- sumaAlt2 [1,2,3] = (3 - 2 + (1 - 0))
-- sumaAlt2 [1,2,3] = (3 - 2 + 1 - 0)

-- sumaAlt2 [1,2,3,4] = (4 - (3 - (2 - (1 - 0))))
-- sumaAlt2 [1,2,3,4] = (4 - 3 + (2 - (1 - 0)))
-- sumaAlt2 [1,2,3,4] = (4 - 3 + 2 - (1 - 0))
-- sumaAlt2 [1,2,3,4] = (4 - 3 + 2 - 1 + 0)
