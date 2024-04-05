data AB a = Nil | Bin (AB a) a (AB a)

foldAB ::
    b                       -- Nil
    -> (b -> a -> b -> b)   -- Bin
    -> AB a
    -> b

-- foldAB cNil cBin Nil = cNil
-- foldAB cNil cBin (Bin l v r) = cBin (foldAB cNil cBin l) v (foldAB cNil cBin r)

foldAB cNil cBin t = case t of
    Nil -> cNil
    (Bin l v r) -> cBin (rec l) v (rec r)
    where rec = foldAB cNil cBin

-- altura
-- ramas
-- #nodos
-- #hojas
-- espejo
