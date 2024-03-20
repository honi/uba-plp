data AB a = Nil | Bin (AB a) a (AB a) deriving(Show)

vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB _ = False

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin left value right) = Bin (negacionAB left) (not value) (negacionAB right)

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin left value right) = value * productoAB left * productoAB right
