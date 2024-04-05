sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = zipWith (zipWith (+))
-- sumaMat xs ys = map (\(x, y) -> zipWith (+) x y) (zip xs ys)

-- trasponer :: [[Int]] -> [[Int]]
-- trasponer [[1,2],[3,4]] = [[1,3],[2,4]]
-- 1 2  ~>  1 3
-- 3 4  ~>  2 4
