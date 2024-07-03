% palíndromo(+L, ?L1), donde L1 es un palíndromo cuya primera mitad es L.
palíndromo(L, L1) :- reverse(L, R), append(L, R, L1).

% iésimo(?I, +L, -X), donde X es el I-ésimo elemento de la lista L.
iésimo(I, L, X) :- append(P, [X|_], L), length(P, N), I is N+1.

% Versión recursiva.
% iésimo(1, [X|_], X).
% iésimo(I, [_|L], X) :- iésimo(J, L, X), I is J+1.
