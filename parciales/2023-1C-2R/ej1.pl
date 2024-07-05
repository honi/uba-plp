árbol(bin(bin(bin(nil, 4, nil), 2, bin(nil, 5, bin(nil, 6, nil))), 1, bin(bin(nil, 7, nil), 3, nil))).

% camino(+A, -C)
camino(nil, []).
camino(bin(nil, X, nil), [X]).
camino(bin(I, X, _), [X|Xs]) :- camino(I, Xs), I \= nil.
camino(bin(_, X, D), [X|Xs]) :- camino(D, Xs), D \= nil.

% caminoMásLargo(+A, -C)
caminoMásLargo(A, C) :-
    caminoDeLongN(A, N, C),
    not((caminoDeLongN(A, N2, _), N2 > N)).

% caminoDeLongN(+A, ?N, -C)
caminoDeLongN(A, N, C) :- camino(A, C), length(C, N).

% caminoÚnicoDeLong(+A, +N, -C)
caminoÚnicoDeLong(A, N, C) :-
    caminoDeLongN(A, N, C),
    not((caminoDeLongN(A, N, C2), C2 \= C)).
