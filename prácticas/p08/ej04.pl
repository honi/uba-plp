% Definir el predicado juntar(?L1, ?L2, ?L3), que tiene éxito si L3 es la concatenación de L1 y L2.

juntar([], L2, L2).
juntar([X|L1], L2, [X|L3]) :- juntar(L1, L2, L3).
