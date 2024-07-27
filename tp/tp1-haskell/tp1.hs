import Test.HUnit
{- HLINT ignore "Use camelCase" -}

{-- Tipos --}

import Data.Either
import Data.List
import Data.Char

data Dirección = Norte | Sur | Este | Oeste
  deriving (Eq, Show)
type Posición = (Float, Float)

data Personaje = Personaje Posición String  -- posición inicial, nombre
  | Mueve Personaje Dirección               -- personaje que se mueve, dirección en la que se mueve
  | Muere Personaje                         -- personaje que muere
  deriving (Eq, Show)
data Objeto = Objeto Posición String        -- posición inicial, nombre
  | Tomado Objeto Personaje                 -- objeto que es tomado, personaje que lo tomó
  | EsDestruido Objeto                      -- objeto que es destruido
  deriving (Eq, Show)
type Universo = [Either Personaje Objeto]

{-- Observadores y funciones básicas de los tipos --}

siguiente_posición :: Posición -> Dirección -> Posición
siguiente_posición p Norte = (fst p, snd p + 1)
siguiente_posición p Sur = (fst p, snd p - 1)
siguiente_posición p Este = (fst p + 1, snd p)
siguiente_posición p Oeste = (fst p - 1, snd p)

posición_objeto :: Objeto -> Posición
posición_objeto = foldObjeto const (const posición_personaje) id

posición :: Either Personaje Objeto -> Posición
posición (Left p) = posición_personaje p
posición (Right o) = posición_objeto o

nombre :: Either Personaje Objeto -> String
nombre (Left p) = nombre_personaje p
nombre (Right o) = nombre_objeto o

nombre_personaje :: Personaje -> String
nombre_personaje = foldPersonaje (const id) const id

está_vivo :: Personaje -> Bool
está_vivo = foldPersonaje (const (const True)) (const (const True)) (const False)

fue_destruido :: Objeto -> Bool
fue_destruido = foldObjeto (const (const False)) const (const True)

universo_con :: [Personaje] -> [Objeto] -> [Either Personaje Objeto]
universo_con ps os = map Left ps ++ map Right os

es_un_objeto :: Either Personaje Objeto -> Bool
es_un_objeto (Left p) = False
es_un_objeto (Right o) = True

es_un_personaje :: Either Personaje Objeto -> Bool
es_un_personaje (Left p) = True
es_un_personaje (Right o) = False

-- Asume que es un personaje
personaje_de :: Either Personaje Objeto -> Personaje
personaje_de (Left p) = p

-- Asume que es un objeto
objeto_de :: Either Personaje Objeto -> Objeto
objeto_de (Right o) = o

en_posesión_de :: String -> Objeto -> Bool
en_posesión_de n = foldObjeto (const (const False)) (\ r p -> nombre_personaje p == n) (const False)

objeto_libre :: Objeto -> Bool
objeto_libre = foldObjeto (const (const True)) (const (const False)) (const False)

norma2 :: (Float, Float) -> (Float, Float) -> Float
norma2 p1 p2 = sqrt ((fst p1 - fst p2) ^ 2 + (snd p1 - snd p2) ^ 2)

cantidad_de_objetos :: Universo -> Int
cantidad_de_objetos = length . objetos_en

cantidad_de_personajes :: Universo -> Int
cantidad_de_personajes = length . personajes_en

distancia :: (Either Personaje Objeto) -> (Either Personaje Objeto) -> Float
distancia e1 e2 = norma2 (posición e1) (posición e2)

objetos_libres_en :: Universo -> [Objeto]
objetos_libres_en u = filter objeto_libre (objetos_en u)

está_el_personaje :: String -> Universo -> Bool
está_el_personaje n = foldr (\x r -> es_un_personaje x && nombre x == n && (está_vivo $ personaje_de x) || r) False

está_el_objeto :: String -> Universo -> Bool
está_el_objeto n = foldr (\x r -> es_un_objeto x && nombre x == n && not (fue_destruido $ objeto_de x) || r) False

-- Asume que el personaje está
personaje_de_nombre :: String -> Universo -> Personaje
personaje_de_nombre n u = foldr1 (\x1 x2 -> if nombre_personaje x1 == n then x1 else x2) (personajes_en u)

-- -- Asume que el objeto está
objeto_de_nombre :: String -> Universo -> Objeto
objeto_de_nombre n u = foldr1 (\x1 x2 -> if nombre_objeto x1 == n then x1 else x2) (objetos_en u)

es_una_gema :: Objeto -> Bool
es_una_gema o = isPrefixOf "Gema de" (nombre_objeto o)

{-Ejercicio 1-}

foldPersonaje ::
  (Posición -> String -> b) ->  -- Personaje Posición String
  (b -> Dirección -> b) ->      -- Mueve Personaje Dirección
  (b -> b) ->                   -- Muere Personaje
  Personaje ->                  -- Personaje a foldear
  b

foldPersonaje cPersonaje cMueve cMuere p = case p of
  Personaje pos nombre -> cPersonaje pos nombre
  Mueve p dir -> cMueve (rec p) dir
  Muere p -> cMuere (rec p)
  where rec = foldPersonaje cPersonaje cMueve cMuere

foldObjeto ::
  (Posición -> String -> b) ->  -- Objeto Posición String
  (b -> Personaje -> b) ->      -- Tomado Objeto Personaje
  (b -> b) ->                   -- EsDestruido Objeto
  Objeto ->                     -- Objeto a foldear
  b

foldObjeto cObjeto cTomado cEsDestruido p = case p of
  Objeto pos nombre -> cObjeto pos nombre
  Tomado o p -> cTomado (rec o) p
  EsDestruido o -> cEsDestruido (rec o)
  where rec = foldObjeto cObjeto cTomado cEsDestruido

{-Ejercicio 2-}

posición_personaje :: Personaje -> Posición
posición_personaje = foldPersonaje (\pos _ -> pos) siguiente_posición id

nombre_objeto :: Objeto -> String
nombre_objeto = foldObjeto (\_ nombre -> nombre) (\r _ -> r) id

{-Ejercicio 3-}

objetos_en :: Universo -> [Objeto]
objetos_en = map objeto_de . filter es_un_objeto

personajes_en :: Universo -> [Personaje]
personajes_en = map personaje_de . filter es_un_personaje

{-Ejercicio 4-}

objetos_en_posesión_de :: String -> Universo -> [Objeto]
objetos_en_posesión_de nombre = filter (en_posesión_de nombre) . objetos_en

{-Ejercicio 5-}

-- Asume que hay al menos un objeto
objeto_libre_mas_cercano :: Personaje -> Universo -> Objeto
objeto_libre_mas_cercano p u = foldl1 (\r o ->
    if distanciaA o <= distanciaA r then o else r
  ) (objetos_libres_en u)
  where distanciaA o = norma2 (posición_personaje p) (posición_objeto o)

{-Ejercicio 6-}

tiene_thanos_todas_las_gemas :: Universo -> Bool
tiene_thanos_todas_las_gemas u = length (filter es_una_gema (objetos_en_posesión_de "Thanos" u)) == 6

{-Ejercicio 7-}

podemos_ganarle_a_thanos :: Universo -> Bool
podemos_ganarle_a_thanos u =
  not (tiene_thanos_todas_las_gemas u) && (
    (está_el_personaje "Thor" u && está_el_objeto "StormBreaker" u)
    || (
      está_el_personaje "Wanda" u &&
      está_el_personaje "Vision" u &&
      está_el_objeto "Gema de la Mente" u &&
      en_posesión_de "Vision" (objeto_de_nombre "Gema de la Mente" u)
    )
  )

{-Tests-}

main :: IO Counts
main = do runTestTT allTests

allTests = test [ -- Reemplazar los tests de prueba por tests propios
  "ejercicio1" ~: testsEj1,
  "ejercicio2" ~: testsEj2,
  "ejercicio3" ~: testsEj3,
  "ejercicio4" ~: testsEj4,
  "ejercicio5" ~: testsEj5,
  "ejercicio6" ~: testsEj6,
  "ejercicio7" ~: testsEj7
  ]

batman = Personaje (0,0) "batman"
joker = Personaje (3,3) "joker"
batimovil = Objeto (2,2) "batimovil"
batiseñal = Objeto (0,0) "batiseñal"

-- Casos de test para el ejercicio 1
testsEj1 = test [
  foldPersonaje (\pos s -> 0) (\r d -> r+1) (\r -> r+1) batman
    ~=? 0
  ,
  foldPersonaje (\pos s -> 0) (\r d -> r+1) (\r -> r+1) (Muere batman)
    ~=? 1
  ,
  foldObjeto (\pos s -> 0) (\r p -> r+1) (\r -> r+1) batimovil
    ~=? 0
  ,
  foldObjeto (\pos s -> 0) (\r p -> r+1) (\r -> r+1) (EsDestruido batimovil)
    ~=? 1
  ]

-- Casos de test para el ejercicio 2
testsEj2 = test [
  posición_personaje batman
    ~=? (0,0)
  ,
  posición_personaje (Mueve (Mueve batman Sur) Este)
    ~=? (1,-1)
  ,
  posición_personaje (Mueve (Mueve batman Norte) Oeste)
    ~=? (-1,1)
  ,
  posición_personaje (Muere batman)
    ~=? (0,0)
  ,
  nombre_objeto batimovil
    ~=? "batimovil"
  ,
  nombre_objeto (Tomado batimovil batman)
    ~=? "batimovil"
  ,
  nombre_objeto (EsDestruido batimovil)
    ~=? "batimovil"
  ]

-- Casos de test para el ejercicio 3
testsEj3 = test [
  objetos_en []
    ~=? []
  ,
  objetos_en [Left batman, Right batimovil]
    ~=? [batimovil]
  ,
  personajes_en []
    ~=? []
  ,
  personajes_en [Left batman, Right batimovil]
    ~=? [batman]
  ]

-- Casos de test para el ejercicio 4
testsEj4 = test [
  objetos_en_posesión_de "batman" []
    ~=? []
  ,
  objetos_en_posesión_de "batman" [Right batimovil]
    ~=? []
  ,
  objetos_en_posesión_de "batman" [Left batman, Right (Tomado batimovil batman)]
    ~=? [Tomado batimovil batman]
  ,
  objetos_en_posesión_de "batman" [Left batman, Right (Tomado (Tomado batimovil batman) joker)]
    ~=? []
  ]

-- Casos de test para el ejercicio 5
testsEj5 = test [
  objeto_libre_mas_cercano batman [Right batimovil]
    ~=? batimovil
  ,
  objeto_libre_mas_cercano batman [Right batimovil, Right batiseñal]
    ~=? batiseñal
  ,
  objeto_libre_mas_cercano batman [Right batimovil, Right (Tomado batiseñal joker)]
    ~=? batimovil
  ]

thanos = Personaje (0,0) "Thanos"
thor = Personaje (0,0) "Thor"
wanda = Personaje (0,0) "Wanda"
vision = Personaje (0,0) "Vision"
stormbreaker = Objeto (0,0) "StormBreaker"
gemaDeLaMente = Objeto (0,0) "Gema de la Mente"
otrasGemas = [Objeto (0,0) ("Gema " ++ n) | n <- ["del Alma", "del Tiempo", "del Espacio", "de la Realidad", "del Poder"]]
gemas = gemaDeLaMente:otrasGemas
gemasTomadas = map (flip Tomado thanos) gemas

-- Casos de test para el ejercicio 6
testsEj6 = test [
  tiene_thanos_todas_las_gemas (universo_con [thanos] gemas)
    ~=? False
  ,
  tiene_thanos_todas_las_gemas (universo_con [thanos] gemasTomadas)
    ~=? True
  ]

-- Casos de test para el ejercicio 7
testsEj7 = test [
  podemos_ganarle_a_thanos (universo_con [thor] [stormbreaker])
    ~=? True
  ,
  podemos_ganarle_a_thanos (universo_con [wanda, vision] [Tomado gemaDeLaMente vision])
    ~=? True
  ,
  podemos_ganarle_a_thanos (universo_con [thanos, thor] (stormbreaker:gemas))
    ~=? True
  ,
  podemos_ganarle_a_thanos (universo_con [thanos, wanda, vision] (Tomado gemaDeLaMente vision:otrasGemas))
    ~=? True
  ,
  podemos_ganarle_a_thanos (universo_con [thanos, thor] ([stormbreaker] ++ gemasTomadas))
    ~=? False
  ,
  podemos_ganarle_a_thanos (universo_con [thanos, wanda, vision] gemasTomadas)
    ~=? False
  ]
