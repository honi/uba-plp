permutaciones :: [a] -> [[a]]
permutaciones =
    foldr (\x rs ->
        concatMap (\r ->
            map (insert x r) [0..length r]
        ) rs
    ) [[]]
    where insert x r i = drop i r ++ [x] ++ take i r

-- Preguntar
partes :: [a] -> [[a]]
partes = foldl (\rs x -> rs ++ map (\r -> r ++ [x]) rs) [[]]

prefijos :: [a] -> [[a]]
prefijos = foldl (\rs x -> rs ++ [last rs ++ [x]]) [[]]

sublistas :: [a] -> [[a]]
-- sublistas [] = [[]]
-- sublistas (x:xs) = map (x :) (prefijos xs) ++ sublistas xs
sublistas = recr (\x xs r -> map (x :) (prefijos xs) ++ r) [[]]

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr f z [] = z
recr f z (x : xs) = f x xs (recr f z xs)
