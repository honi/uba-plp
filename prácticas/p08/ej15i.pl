% cuadradoSemiLatino(+N, -C)

cuadradoSemiLatino(N, C) :-
    desde(0, K),                % Generación infinita de todas las posibles sumas.
    length(C, N),               % Como length es reversible lo usamos para instanciar
                                % C en una lista de N elementos.
    filasQueSumaK(N, K, C).     % Pedimos que cada fila de C sume K.

% filasQueSumaK(+N, +K, ?C): Instancia C con M filas de largo N que suman K.
filasQueSumaK(_, _, []).
filasQueSumaK(N, K, [X|Xs]) :-
    filaQueSumaK(N, K, X),
    filasQueSumaK(N, K, Xs).

% filaQueSumaK(+N, +K, -F): Instancia F en todas las filas de largo N que suman K.
filaQueSumaK(0, 0, []).
filaQueSumaK(N, K, [X|Xs]) :-
    N > 0,
    between(0, K, X),           % Generación acotada.
    K2 is K-X,
    N2 is N-1,
    filaQueSumaK(N2, K2, Xs).   % Pedimos que Xs tenga N-1 elementos y que sumen K-X.

% desde(+X, -Y): instancia Y en todos los números naturales >= X.
desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).
