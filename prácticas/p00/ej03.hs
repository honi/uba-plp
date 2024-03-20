inverso :: Float -> Maybe Float
inverso n
    | n /= 0 = Just (1 / n)
    | otherwise = Nothing

aEntero :: Either Int Bool -> Int
aEntero (Left n) = n
aEntero (Right b) = fromEnum b
