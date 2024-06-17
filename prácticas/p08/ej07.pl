% palíndromo(+L, ?L1), donde L1 es un palíndromo cuya primera mitad es L.
palíndromo(L, L1) :- reverse(L, R), append(L, R, L1).

% iésimo(?I, +L, -X), donde X es el I-ésimo elemento de la lista L.
iésimo(1, [X|L], X).
iésimo(I, [Y|L], X) :- iésimo(J, L, X), I is J+1.
