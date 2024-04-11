-- sumaMat [[1,2],[3,4],[5,6]] [[7,8],[9,10],[11,12]]
-- [[1+7,2+8],[3+9,4+10],[5+11,6+12]]
-- [[8,10],[12,14],[16,18]]

sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = zipWith (zipWith (+))
-- sumaMat xs ys = map (\(x, y) -> zipWith (+) x y) (zip xs ys)

-- trasponer [[1,2,3],[4,5,6],[7,8,9]]
-- [1 2 3]  ~>  [1 4 7]
-- [4 5 6]  ~>  [2 5 8]
-- [7 8 9]  ~>  [3 6 9]
-- [[],[],[]]
-- [[],[],[]] + [1,2,3]           ~>  [[1],[2],[3]]
-- [[1],[2],[3]] + [4,5,6]        ~>  [[1,4],[2,5],[3,6]]
-- [[1,4],[2,5],[3,6]] + [7,8,9]  ~>  [[1,4,7],[2,5,8],[3,6,9]]

-- trasponer [[1,2],[4,5],[7,8]]
-- [1 2]  ~>  [1 4 7]
-- [4 5]  ~>  [2 5 8]
-- [7 8]  ~>

trasponer :: [[Int]] -> [[Int]]
trasponer = foldl (\rec x -> zipWith (++) rec (map (:[]) x)) (repeat [])
