padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X, Y) :- padre(X, Z), padre(Z, Y).

% X es hijo de Y si Y es padre de X.
hijo(X, Y) :- padre(Y, X).

% X es hermano de Y si tienen el mismo padre.
hermano(X, Y) :- padre(Z, X), padre(Z, Y), not(X = Y).

% X es descendiente de Y si:
% - X es el hijo directo de Y.
% - X es el hijo de algún descendiente de Y.
descendiente(X, Y) :- hijo(X, Y).
descendiente(X, Y) :- hijo(X, Z), descendiente(Z, Y).

% Versión rota:
% ancestro(X, X).
% ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

/*
Cuando consultamos ancestro(juan, X) obtenemos el primer resultado por la regla
ancestro(X, X) que unifica X = juan.

Si pedimos más resultados, entramos en la segunda regla donde se unifica X = juan, y
se consulta recursivamente ancestro(Z, Y). Esta nueva consulta comienza desde cero,
entonces entra por la primer regla y unifica Z = Y. Ahora continuamos hacia la derecha
y buscamos resolver padre(juan, Y) (por la primer unificación que nos dio X = juan).
Los próximos 2 resultados: carlos y luis se obtienen unificando con las reglas de padre.

Si pedimos aún más resultados, backtrackeamos a la consulta ancestro(Z, Y) y en vez de
entrar en la primer regla, entramos en la segunda regla. Ahora sucede recursivamente
todo lo antes descripto pero "un nivel más adentro", y lo que terminamos unificando son
varios niveles de padre: padre(juan, Y1), padre(Y1, Y2). Esto genera los 5 nietos de
juan.

Finalmente, si intentamos pedir un resultado más después del último nieto (ramiro),
caemos en una resolución infinita entrando siempre por la segunda regla de ancestro,
intentando buscar el padre del padre del padre del padre del padre...
*/

% Versión arreglada:
ancestro(X, Y) :- padre(X, Y).
ancestro(X, Y) :- padre(Z, Y), ancestro(X, Z).

% Nietos de juan:
% abuelo(juan, X).

% Todos los hermanos de pablo:
% hermano(pablo, X).
