max2 :: (Float, Float) -> Float
max2 (x, y)
    | x >= y = x
    | otherwise = y

max2Curried :: Float -> Float -> Float
max2Curried x y = max2 (x, y)

normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x^2 + y^2)

normaVectorialCurried :: Float -> Float -> Float
normaVectorialCurried x y = normaVectorial (x, y)

_subtract :: Float -> Float -> Float
_subtract = flip (-)

predecesor :: Float -> Float
predecesor = _subtract 1

evaluarEnCero :: (Float -> a) -> a
evaluarEnCero = \f -> f 0

dosVeces :: (a -> b) -> (a -> b)
dosVeces = \f -> f . f

flipAll :: [a -> b -> c] -> [b -> a -> c]
flipAll = map flip

flipRaro :: b -> (a -> b -> c) -> a -> c
flipRaro = flip flip
