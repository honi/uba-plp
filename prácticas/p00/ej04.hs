limpiar :: String -> String -> String
limpiar a = filter (not . flip elem a)

difPromedio :: [Float] -> [Float]
difPromedio xs = map (flip (-) promedio) xs
    where
        suma = foldl (+) 0 xs
        promedio = suma / fromIntegral (length xs)

todosIguales :: [Int] -> Bool
todosIguales [] = True
todosIguales (x:xs) = foldr ((&&) . (== x)) True xs
