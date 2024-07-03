% intersección(+L1, +L2, -L3), tal que L3 es la intersección sin repeticiones de las listas L1 y L2,
% respetando en L3 el orden en que aparecen los elementos en L1.

% Caso base.
intersección([], _, []).

% Caso X no pertenece a L2
intersección([X|L1], L2, Rs) :-
    not(member(X, L2)),
    intersección(L1, L2, Rs).

% Caso X sí pertenece a L2.
intersección([X|L1], L2, [X|L3]) :-
    sacarDuplicados(L1, T1),
    sacarDuplicados(L2, T2),
    member(X, T2),
    intersección(T1, T2, L3).

% partir(N, L, L1, L2), donde L1 tiene los N primeros elementos de L, y L2 el resto.
% Si L tiene menos de N elementos el predicado debe fallar.

partir(0, L, [], L).
partir(N, [X|L], [X|L1], L2) :- partir(N2, L, L1, L2), N is N2+1.

/*
¿Cuán reversible es este predicado? Es decir, ¿qué parámetros pueden estar indefinidos al momento de la invocación?
Todos los parámetros pueden estar indefinidos.
*/

% borrar(+ListaOriginal, +X, -ListaSinXs), que elimina todas las ocurrencias de X de la lista ListaOriginal.

borrar([], _, []).
borrar([X|Xs], X, Ys) :- borrar(Xs, X, Ys).
borrar([X|Xs], Y, [X|Ys]) :- X \= Y, borrar(Xs, Y, Ys).

% sacarDuplicados(+L1, -L2), que saca todos los elementos duplicados de la lista L1.

sacarDuplicados([], []).
sacarDuplicados([X|L1], L2) :-
    sacarDuplicados(L1, Ys),
    borrar(Ys, X, Xs),
    append([X], Xs, L2).

% permutación(+L1, ?L2), que tiene éxito cuando L2 es permutación de L1. ¿Hay una manera más eficiente
% de definir este predicado para cuando L2 está instanciada?

permutación([], []).
permutación([X|Xs], Ys) :- permutación(Xs, Zs), insertar(X, Zs, Ys).

insertar(X, L, LX) :- append(P, S, L), append(P, [X|S], LX).

% reparto(+L, +N, -LListas) que tenga éxito si LListas es una lista de N listas (N ≥ 1) de cualquier
% longitud - incluso vacías - tales que al concatenarlas se obtiene la lista L.

% repartoSinVacías(+L, -LListas) similar al anterior, pero ninguna de las listas de LListas puede ser
% vacía, y la longitud de LListas puede variar.
