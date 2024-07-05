% palabra(+A, +N, -P)

palabra(_, 0, []).
palabra(A, N, [X|Xs]) :-
    N > 0,
    N2 is N-1,
    member(X, A),
    palabra(A, N2, Xs).

% frase(+A, -F)
frase(A, F) :-
    % N es la cantidad total de letras entre todas las palabras.
    desde(0, N),
    palabras(A, N, F).

palabras(_, 0, []).
palabras(A, N, [P|Ps]) :-
    N > 0,
    between(1, N, K),
    palabra(A, K, P),
    N2 is N-K,
    palabras(A, N2, Ps).

desde(X, X).
desde(X, Y) :- X2 is X+1, desde(X2, Y).
