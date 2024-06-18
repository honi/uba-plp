% Escribir el predicado elementosTomadosEnOrden(+L,+N,-Elementos) que tenga éxito si L es una lista, N ≥ 0 y
% Elementos es una lista de N elementos de L, preservando el orden en que aparecen en la lista original.

% Esta implementación es demasiado paradigma funcional.
% Es casi una copia de la implementación de take en Haskell.
% elementosTomadosEnOrden(_, 0, []).
% elementosTomadosEnOrden([], _, []).
% elementosTomadosEnOrden([X|L], N, [X|E]) :- N > 0, N2 is N-1, elementosTomadosEnOrden(L, N2, E).

elementosTomadosEnOrden(L, N, E) :- length(E, N), append(E, _, L).
