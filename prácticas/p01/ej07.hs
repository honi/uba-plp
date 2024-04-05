genLista :: a -> (a -> a) -> Int -> [a]
genLista n f 0 = []
genLista n f i = n : genLista (f n) f (i-1)

-- Con funciones del preludio.
-- genLista n f i = take i (iterate f n)

desdeHasta :: Int -> Int -> [Int]
desdeHasta i j = genLista i (+1) (j-i+1)
