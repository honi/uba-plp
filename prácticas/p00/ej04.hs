limpiar :: String -> String -> String
limpiar "" bs = bs
limpiar (a:as) bs = limpiar as (filter (/= a) bs)

difPromedio :: [Float] -> [Float]
difPromedio xs = map (flip (-) promedio) xs
    where
        suma = foldl (+) 0 xs
        promedio = suma / fromIntegral (length xs)

todosIguales :: [Int] -> Bool
todosIguales [] = True
todosIguales [x] = True
todosIguales (x:xs) = foldl (&&) True (map (== x) xs)
