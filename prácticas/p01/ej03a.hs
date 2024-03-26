sum :: [Integer] -> Integer
sum = foldr (+) 0

elem :: (Foldable t, Eq a) => a -> t a -> Bool
elem e = foldr ((||) . (== e)) False

(++) :: [Integer] -> [Integer] -> [Integer]
(++) = flip (foldr (:))

filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr (\x r -> if f x then x:r else r) []

map :: (a -> b) -> [a] -> [b]
map f = foldr ((:) . f) []
