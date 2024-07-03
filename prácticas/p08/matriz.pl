% matriz(+N, -X): instancia X en una matriz de NxN.
matriz(N, X) :- length(X, N), filasDeLargoN(N, X).

% filasDeLargoN(+N, ?Xs): instancia todos los elementos de Xs en filas de largo N.
% Si Xs ya es una lista entonces este predicado termina.
% Si Xs está sin instanciar genera las infinitas listas de (listas de largo N).
filasDeLargoN(_, []).
filasDeLargoN(N, [X|Xs]) :- length(X, N), filasDeLargoN(N, Xs).


% Otra forma es agregar otro argumento para generar las N filas.
% Necesitamos otro argumento porque también hay que mantener fijo el N para pedir que
% cada fila tenga N elementos.

% matriz2(+N, -X): instancia X en una matriz de NxN.
matriz2(N, X) :- filasDeLargoN2(N, N, X).

% filasDeLargoN2(+M, +N, -X): instancia X en una lista de N elementos, cada uno siendo
% a su vez una lista de largo N.
filasDeLargoN2(0, _, []).
filasDeLargoN2(M, N, [X|Xs]) :- M > 0, length(X, N), M2 is M-1, filasDeLargoN2(M2, N, Xs).
