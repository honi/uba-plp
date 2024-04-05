recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna y = recr (\x xs r -> if x == y then xs else x:r) []

-- No podemos implementar sacarUna con foldr porque no hay "memoria".
-- Cada vez que procesamos un elemento, no sabemos si ya sacamos algún
-- elemento anterior o no. Dicho de otra manera, con foldr no podemos
-- hacer un return temprano y "abortar" el resto del fold.

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado y = recr (\x xs r ->if y <= x then y:x:xs else x:r) [y]
