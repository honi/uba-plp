data Polinomio a = X
    | Cte a
    | Suma (Polinomio a) (Polinomio a)
    | Prod (Polinomio a) (Polinomio a)
    deriving(Show)

evaluar :: Num a => a -> Polinomio a -> a
evaluar x X = x
evaluar _ (Cte c) = c
evaluar x (Suma p q) = evaluar x p + evaluar x q
evaluar x (Prod p q) = evaluar x p * evaluar x q

-- X^2 + X + 1
-- evaluar 1 (Suma (Prod X X) (Suma X (Cte 1)))

foldPoli ::
    b               -- X
    -> (a -> b)       -- Cte
    -> (b -> b -> b)  -- Suma
    -> (b -> b -> b)  -- Prod
    -> Polinomio a
    -> b

foldPoli cX cCte cSuma cProd t = case t of
    X -> cX
    Cte c -> cCte c
    Suma p q -> cSuma (rec p) (rec q)
    Prod p q -> cProd (rec p) (rec q)
    where rec = foldPoli cX cCte cSuma cProd

evaluarFoldeado :: Num a => a -> Polinomio a -> a
evaluarFoldeado x = foldPoli x id (+) (*)
