% Otra versión.

% palabra(+A, +N, -P)
palabra(A, N, P) :-
    length(P, N),
    esPalabra(A, P).

% esPalabra(+A, +P)
esPalabra(_, []).
esPalabra(A, [X|Xs]) :-
    member(X, A),
    esPalabra(A, Xs).

% frase(+A, -F)
frase(A, F) :-
    % N es la cantidad total de letras entre todas las palabras.
    desde(0, N),
    palabras(A, N, F).

palabras(A, 0, []).
palabras(A, N, [P|Ps]) :-
    N > 0,
    between(1, N, K),
    length(P, K),
    esPalabra(A, P),
    N2 is N-K,
    palabras(A, N2, Ps).

desde(X, X).
desde(X, Y) :- X2 is X+1, desde(X2, Y).
