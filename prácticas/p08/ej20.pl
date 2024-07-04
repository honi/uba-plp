% P(+X)
p(X) :- X > 10.

% minX(-X)
minX(X) :-
    desde(0, X),
    % Buscamos un X que cumple p(X).
    p(X),
    X2 is X-1,
    % Ningún 0 <= Y < X cumple p(Y).
    not((between(0, X2, Y), p(Y))),
    % Entonces X es el mínimo tal que p(X). No buscamos más resultados.
    % Cómo evitamos el cut??
    !.

desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).
