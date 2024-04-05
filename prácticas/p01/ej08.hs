mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f)

-- armarPares :: [a] -> [b] -> [(a, b)]
-- armarPares _ [] = []
-- armarPares [] _ = []
-- armarPares (x:xs) (y:ys) = (x, y) : armarPares xs ys

armarPares :: [a] -> [b] -> [(a, b)]
armarPares = foldr (\x rec ys ->
        if null ys then []
        else (x, head ys) : rec (tail ys)
    ) (const [])

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f = foldr (\x rec ys ->
        if null ys then []
        else f x (head ys) : rec (tail ys)
    ) (const [])
