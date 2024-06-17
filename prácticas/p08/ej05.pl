% last(?L, ?U), donde U es el último elemento de la lista L.
last(L, U) :- append(_, [U], L).

% Versión alternativa sin append.
% last([U], U).
% last([_|L], U) :- last(L, U).

% reverse(+L, -L1), donde L1 contiene los mismos elementos que L, pero en orden inverso.
reverse([], []).
reverse([X|L], P) :- reverse(L, R), append(R, [X], P).

% prefijo(?P, +L), donde P es prefijo de la lista L.
prefijo(P, L) :- append(P, _, L).

% sufijo(?S, +L), donde S es sufijo de la lista L.
sufijo(S, L) :- append(_, S, L).

% sublista(?S, +L), donde S es sublista de L.
sublista([], _).
sublista([X|Xs], L) :- prefijo(P, L), sufijo([X|Xs], P).

% pertenece(?X, +L), que es verdadero sii el elemento X se encuentra en la lista L.
pertenece(X, L) :- sublista([X], L).
