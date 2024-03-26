curry :: ((a, b) -> c) -> a -> b -> c
curry f a b = f (a, b)

uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (a, b) = f a b

-- Preguntar
curryN :: ((a, bs...) -> c) -> a -> bs... -> c
curryN f a bs = f (a, bs...)
