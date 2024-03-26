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
cantDivisoresPrimos n = sum (map esDivisible primos)
    where
        primos = criba [2..(floor (sqrt (fromIntegral n)))]
        esDivisible = fromEnum . (== 0) . (n `mod`)

criba :: [Int] -> [Int]
criba [] = []
criba (x:xs) = x : criba (filter ((/= 0) . (`mod` x)) xs)

primerosPrimos = take 1000 (criba [2..])
