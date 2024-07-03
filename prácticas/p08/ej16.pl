% esTriángulo(+T)
esTriángulo(tri(A, B, C)) :- A < B+C, B < A+C, C < A+B, A > B-C.

% perímetro(?T, ?P)
perímetro(tri(A, B, C), P) :-
    ground(tri(A, B, C)),
    esTriángulo(tri(A, B, C)),
    P is A+B+C.

perímetro(tri(A, B, C), P) :-
    not(ground(tri(A, B, C))),
    armarTriplas(A, B, C, P),
    esTriángulo(tri(A, B, C)).

% triángulo(-T)
triángulo(T) :- perímetro(T, _).

armarTriplas(A, B, C, P) :-
    desde(3, P),
    between(1, P, A),
    between(1, P, B),
    between(1, P, C),
    P =:= A+B+C.

desde(X, X).
desde(X, Y) :- var(Y), N is X+1, desde(N, Y).
desde(X, Y) :- nonvar(Y), X < Y.
