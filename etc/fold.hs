foldr f z []     = z
foldr f z (x:xs) = f x (foldr f z xs)

foldr + 0 [1,2,3]
+ 1 (foldr + 0 [2,3])
+ 1 (+ 2 (foldr + 0 [3]))
+ 1 (+ 2 (+ 3 (foldr + 0 [])))
+ 1 (+ 2 (+ 3 0))
1 + (2 + (3 + 0))
T | (T | (F | T))

foldl f z []     = z
foldl f z (x:xs) = foldl f (f z x) xs

foldl + 0 [1,2,3]
foldl + (+ 0 1) [2,3]
foldl + (+ (+ 0 1) 2) [3]
foldl + (+ (+ (+ 0 1) 2) 3) []
+ (+ (+ 0 1) 2) 3
((0 + 1) + 2) + 3
((T | F) | T) | T
