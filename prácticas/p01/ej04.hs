permutaciones :: [a] -> [[a]]
permutaciones =
    foldr (\x r ->
        concatMap (\r ->
            map (insert x r) [0..length r]
        ) r
    ) [[]]
    where insert x r i = drop i r ++ [x] ++ take i r
