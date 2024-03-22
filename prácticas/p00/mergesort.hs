merge :: [Int] -> [Int] -> [Int]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

mergesort :: [Int] -> [Int]
mergesort [] = []
mergesort [x] = [x]
mergesort xs = merge (mergesort (take left xs)) (mergesort (drop left xs))
    where
        left = length xs `div` 2
