:- ensure_loaded('ej15i.pl').

% cuadradoMágico(+N, -C)
cuadradoMágico(N, C) :-
    cuadradoSemiLatino(N, C),
    nth1(1, C, F1),
    sum_list(F1, K),
    not((between(1, N, I), columna(I, C, X), sum_list(X, K2), K2 \== K)).

% columna(+I, +Fs, -Xs): instancia Xs en la columna I-ésima de la matriz Fs.
columna(_, [], []).
columna(I, [F|Fs], [X|Xs]) :- nth1(I, F, X), columna(I, Fs, Xs).
