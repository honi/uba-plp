% sublistaMasLargaDePrimos(+L, ?P)

sublistaMasLargaDePrimos(L, P) :-
    sublistaDePrimos(L, P),
    length(P, N),
    not((sublistaDePrimos(L, P2), length(P2, N2), N2 > N)).

sublistaDePrimos(L, S) :- sublista(S, L), sonTodosPrimos(S).

sublista([], _).
sublista(S, L) :- append(P, _, L), append(_, S, P), S \= [].

sonTodosPrimos([]).
sonTodosPrimos([X|Xs]) :- esPrimo(X), sonTodosPrimos(Xs).

esPrimo(P) :- P > 1, P2 is P-1, not((between(2, P2, D), mod(P, D) =:= 0)).
