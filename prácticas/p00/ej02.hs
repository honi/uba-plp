valorAbsoluto :: Float -> Float
valorAbsoluto n
    | n < 0 = -n
    | otherwise = n

bisiesto :: Int -> Bool
bisiesto n
    | n `mod` 100 == 0 = n `mod` 400 == 0
    | otherwise = n `mod` 4 == 0

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos n = foldl (+) 0 (map esDivisible (filter esPrimo [1..n]))
    where esDivisible = fromEnum . (== 0) . (n `mod`)

esPrimo :: Int -> Bool
esPrimo 1 = False
esPrimo n = cantDivisores n == 2

cantDivisores :: Int -> Int
cantDivisores n = cantDivisoresDesde n 1

cantDivisoresDesde :: Int -> Int -> Int
cantDivisoresDesde n m
    | m > n = 0
    | n `mod` m == 0 = 1 + cantDivisoresDesde n (m+1)
    | otherwise = cantDivisoresDesde n (m+1)
