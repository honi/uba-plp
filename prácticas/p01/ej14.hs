import Ej13

ramas :: AB a -> [[a]]
ramas = foldAB [] f
    where
        f rl v rr
            | null rl && null rr = [[v]]
            | null rr = map (v:) rl
            | null rl = map (v:) rr
            | otherwise = map (v:) rl ++ map (v:) rr

-- Identificamos una hoja cuando la cantidad de hojas
-- en sus dos subárboles (izquierdo y derecho) son 0.
cantHojas :: AB a -> Int
cantHojas = foldAB 0 (\rl v rr -> if rl == 0 && rr == 0 then 1 else 0 + rl + rr)

espejo :: AB a -> AB a
espejo = foldAB Nil (\rl v rr -> Bin rr v rl)

mismaEstructura :: AB a -> AB b -> Bool
mismaEstructura = recAB esNil f
    where
        f xl _ xr xrl xrr y = case y of
            Nil -> False -- Bin(...) != Nil
            (Bin yl _ yr) -> esNil xl == esNil yl && esNil xr == esNil yr && xrl yl && xrr yr
