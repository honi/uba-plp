% Caso fácil: p(X) instancia un conjunto finito de soluciones.

% p(X) ≡ 10 ≤ X ≤ 20
p(X) :- between(10, 20, X).

% minP(X) ≡ p(X) ∧ ¬∃Y.(0 ≤ Y < X ∧ p(Y))
minP(X) :- p(X), X2 is X-1, not((between(0, X2, Y), p(Y))).

% --------------------------------------------------------------------------------------

% Caso difícil: q(X) tiene infinitas soluciones.

q(X) :- X > 10.

% Empezamos a buscar desde 0 el mínimo X tal que q(X).
minQ(X) :- minQDesde(0, X).

% minQDesde(+X, -Y).

% El 1er argumento siempre está instanciado. Probamos si ese X cumple q(X).
minQDesde(X, X) :- q(X).

% Si minQDesde(X, X) no unificó o pedimos más soluciones, la idea es incrementar X1
% en 1 para probar con el siguiente número natural. Para evitar que se cuelge o que
% genere más de una solución (como buscamos el mínimo la solución es única si existe),
% únicamente probamos con X1+1 si no vale q(X1). Si vale q(X1), cualquier X2 > X1
% no va a ser el mínimo y por lo tanto no nos interesa esa solución.
minQDesde(X1, X) :- not(q(X1)), X2 is X1+1, minQDesde(X2, X).

% --------------------------------------------------------------------------------------

% Versión con trampa: usar cut para frenar la generación infinita de desde/2.

r(X) :- X > 10.

minR(X) :-
    desde(0, X),
    % Buscamos un X que cumple r(X).
    r(X),
    X2 is X-1,
    % Ningún 0 <= Y < X cumple r(Y).
    not((between(0, X2, Y), r(Y))),
    % Entonces X es el mínimo tal que r(X). No buscamos más resultados.
    !.

desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).
