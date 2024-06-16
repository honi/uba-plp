natural(0).
natural(suc(X)) :- natural(X).

% Versión rota:
% menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
% menorOIgual(X, X) :- natural(X).

/*
Al consultar menorOIgual(0, X) entramos en una ejecución infinita por la primer regla.
X := suc(Y)
Y := suc(Y2)
Y2 := suc(Y3)
...
Intenamos unificar X con un número cada vez más grande: X := suc(suc(suc(...))).
*/

/*
Como Prolog resuelve las reglas de arriba hacia abajo, de izquierda a derecha, es
importante el orden en que definimos las reglas. Los "casos base" tienen que estar
primeros, y también es importante cortar el "caso recursivo" si ya no hay soluciones
válidas. Si no cuando pedimos más resultados a Prolog podemos nunca llegar al false y
entrar en una ejecución infinita.
*/

% Versión arreglada.
menorOIgual(X, X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
