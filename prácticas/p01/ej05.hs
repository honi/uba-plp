elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) =
    if null xs then [x]
    else x : elementosEnPosicionesPares (tail xs)
-- No es recursión estructural porque en el caso else,
-- la recursión se hace sobre tail xs en vez de xs entero.
-- Se "descartan" elementos en la recursión sobre xs.

entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x:xs) = \ys ->
    if null ys then x : entrelazar xs []
    else x : head ys : entrelazar xs (tail ys)

entrelazar2 :: [a] -> ([a] -> [a])
entrelazar2 = foldr (\x fr ys ->
        if null ys then x : fr []
        else x : head ys : fr (tail ys)
    ) id
