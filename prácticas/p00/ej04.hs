limpiar :: String -> String -> String
limpiar a b = filter (not . flip elem a) b

difPromedio :: [Float] -> [Float]
difPromedio xs = map (flip (-) promedio) xs
    where
        suma = foldl (+) 0 xs
        promedio = suma / fromIntegral (length xs)

todosIguales :: [Int] -> Bool
todosIguales [] = True
todosIguales (x:xs) = foldr (&&) True (map (== x) xs)
