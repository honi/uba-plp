:- ensure_loaded('ej12.pl').

% inorder(+AB, -Lista), que tenga éxito si AB es un árbol binario y Lista la lista de sus nodos según el recorrido inorder.

inorder(nil, []).
inorder(bin(I, V, D), L) :- inorder(I, LI), inorder(D, LD), append(LI, [V|LD], L).

% arbolConInorder(+Lista, -AB), versión inversa del predicado anterior.

arbolConInorder([], nil).
arbolConInorder(L, bin(I, X, D)) :-
    append(LI, [X|LD], L),  % LI, LD son las sublistas inorder de los subárboles izq/der.
    arbolConInorder(LI, I),
    arbolConInorder(LD, D).

% aBB(+T), que será verdadero si T es un árbol binario de búsqueda.

aBB(nil).
aBB(bin(I, V, D)) :-
    aBB(I), aBB(D),     % Los subárboles izq/der también son aBB.
    inorder(I, LI),
    max_list([V|LI], V),   % V es >= que todos los valores del subárbol izq.
    inorder(D, LD),
    min_list([V|LD], V).   % V es <= que todos los valores del subárbol der.

% aBBInsertar(+X, +T1, -T2), donde T2 resulta de insertar X en orden en el árbol T1.

aBBInsertar(X, nil, bin(nil, X, nil)).          % Insertar en el árbol vacío.
aBBInsertar(X, bin(I, X, D), bin(I, X, D)).     % aBB no tiene valores repetidos.
aBBInsertar(X, bin(I, Y, D), bin(T, Y, D)) :-
    X < Y, aBBInsertar(X, I, T).                % Insertar en el subárbol izq.
aBBInsertar(X, bin(I, Y, D), bin(I, Y, T)) :-
    X > Y, aBBInsertar(X, D, T).                % Insertar en el subárbol der.

% Este predicado ¿es reversible en alguno de sus parámetros? Justificar.
% Podemos revertir +T2 para chequear si T2 es el resultado de insertar X en T1.
% Pero no podemos revertir T1 ni X porque las comparaciones X < Y, X > Y requieren
% ambas variables instanciadas.
