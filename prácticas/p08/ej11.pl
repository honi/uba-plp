% Definir el predicado intercalar(L1, L2, L3), donde L3 es el resultado de intercalar uno a uno los elementos de las
% listas L1 y L2. Si una lista tiene longitud menor, entonces el resto de la lista más larga es pasado sin cambiar.
% Indicar la reversibilidad, es decir si es posible obtener L3 a partir de L1 y L2, y viceversa.

intercalar([], [], []).
intercalar([X|Xs], [], [X|Xs]).
intercalar([], [Y|Ys], [Y|Ys]).
intercalar([X|Xs], [Y|Ys], [X,Y|Zs]) :- intercalar(Xs, Ys, Zs).

% Es completamente reversible: intercalar(L1?, L2?, L3?).

% Revisar: está muy paradigma funcional.
