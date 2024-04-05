takeN :: Int -> [a] -> [a]
takeN = flip (foldr (\x rec i ->
        if i == 0 then []
        else x : rec (i-1)
    ) (const []))
