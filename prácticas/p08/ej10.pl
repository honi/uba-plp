desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).

/*
¿Cómo deben instanciarse los parámetros para que el predicado funcione?
(Es decir, para que no se cuelgue ni produzca un error). ¿Por qué?

desde(+X, -Y)

- En la segunda regla, N is X+1 solo funciona si X está instanciado.
- Si Y viene instanciado, por la segunda regla entramos en una resolución infinita.
  Y solo puede ser igual a X en un único punto, así que cuando X > Y nunca más
  podemos unificar X = Y.
*/

desde2(X, X).
desde2(X, Y) :- var(Y), N is X+1, desde2(N, Y).
desde2(X, Y) :- nonvar(Y), X < Y.
