foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat f z 0 = z
foldNat f z n = f n (foldNat f z (n-1))

-- f 3 (f 2 (f 1 z))

potencia :: Integer -> Integer -> Integer
potencia x = foldNat (\_ rec -> rec * x) 1
