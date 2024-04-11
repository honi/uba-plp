import Ej13

-- Preguntar
ramas :: AB a -> [[a]]
ramas = recAB [] f
    where
        f l v r rl rr
            | esNil l && esNil r = [[v]]
            | esNil r = map (v:) rl
            | esNil l = map (v:) rr
            | otherwise = map (v:) rl ++ map (v:) rr


cantHojas :: AB a -> Int
cantHojas = recAB 0 (\l v r rl rr -> fromEnum (esNil l && esNil r) + rl + rr)

espejo :: AB a -> AB a
espejo = foldAB Nil (\rl v rr -> Bin rr v rl)
