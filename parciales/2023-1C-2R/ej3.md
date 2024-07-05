# Resolución

```prolog
frutal(frutilla).
frutal(banana).
cremoso(banana).
cremoso(americana).
cremoso(frutilla).
leGusta(X) :- frutal(X), cremoso(X).
cucurucho(X, Y) :- leGusta(X), leGusta(Y).
```

```prolog
?- cucurucho(X, Y).
```

## a)

**Convertir la base de conocimientos y la consulta a forma clausal.**

```
1:  { frutal(frutilla) }
2:  { frutal(banana) }
3:  { cremoso(banana) }
4:  { cremoso(americana) }
5:  { cremoso(frutilla) }
6:  { ¬frutal(X), ¬cremoso(X), leGusta(X) }
7:  { ¬leGusta(X), ¬leGusta(Y), cucurucho(X, Y) }
```

```
{ cucurucho(X, Y) }
```

## b)

**Utilizar el método de resolución para obtener el resultado de la consulta.**

Negamos la consulta para obtener el primer objetivo (goal).

```
8:  { ¬cucurucho(X, Y) }
```

**Unificamos `8` con `7` para obtener `9`**

```
8:  { ¬cucurucho(X, Y) }
7:  { ¬leGusta(X9), ¬leGusta(Y9), cucurucho(X9, Y9) }

S9 = mgu({ cucurucho(X9, Y9) ≟ cucurucho(X, Y) }) = { X9 := X, Y9 := Y }
9:  { ¬leGusta(X), ¬leGusta(Y) }
```

**Unificamos `9` con `6` para obtener `10`**

```
9:  { ¬leGusta(X), ¬leGusta(Y) }
6:  { ¬frutal(X10), ¬cremoso(X10), leGusta(X10) }

S10 = mgu({ leGusta(X10) ≟ leGusta(X) }) = { X10 := X }
10: { ¬frutal(X), ¬cremoso(X), ¬leGusta(Y) }
```

Se podría haber usado resolución general y unificado los 2 sabores al mismo tiempo:
```
S10 = mgu({ leGusta(X) ≟ leGusta(Y) ≟ leGusta(X10) })
```

**Unificamos `10` con `1` para obtener `11`**

```
10: { ¬frutal(X), ¬cremoso(X), ¬leGusta(Y) }
1:  { frutal(frutilla) }

S11 = mgu({ X ≟ frutilla }) = { X := frutilla }
11: { ¬cremoso(frutilla), ¬leGusta(Y) }
```

**Unificamos `11` con `5` para obtener `12`**

```
11: { ¬cremoso(frutilla), ¬leGusta(Y) }
5:  { cremoso(frutilla) }

S12 = mgu({ frutilla ≟ frutilla }) = {}
12: { ¬leGusta(Y) }
```

**Unificamos `12` con `6` para obtener `13`**

Ahora se repiten un poco las mismas resoluciones para obtener la sustitución del otro sabor `Y`.

```
12: { ¬leGusta(Y) }
6:  { ¬frutal(X13), ¬cremoso(X13), leGusta(X13) }

S13 = mgu({ leGusta(X13) ≟ leGusta(Y) }) = { X13 := Y }
13: { ¬frutal(Y), ¬cremoso(Y) }
```

**Unificamos `13` con `1` para obtener `14`**

```
13: { ¬frutal(Y), ¬cremoso(Y) }
1:  { frutal(frutilla) }

S14 = mgu({ Y ≟ frutilla }) = { Y := frutilla }
14: { ¬cremoso(frutilla) }
```

**Unificamos `14` con `5` para obtener `15`**

```
14: { ¬cremoso(frutilla) }
5:  { cremoso(frutilla) }

S15 = mgu({ frutilla ≟ frutilla }) = {}
15: { }
```

Llegamos a la cláusula vacía. `⊬ ¬cucurucho(X, Y)` entonces `⊢ cucurucho(X, Y)` con la sustitución `{ X := frutilla, Y := frutilla }`.

## c)

**La resolución es SLD? En caso de serlo, respeta el orden en que Prolog hubiera resuelto la consulta?**

La resolución es SLD porque todas las cláusulas son de Horn y aplicamos la resolvente de formal lineal desde la cláusula objetivo.

Utilizamos las cláusulas en orden de definición (de arriba hacia abajo), volviendo a comenzar la búsqueda desde arriba en cada paso. Además siempre unificamos las fórmulas de izquierda a derecha en cada paso. Este orden es el mismo que haría Prolog.
