% listaDeArboles(-L)
listaDeArboles(L) :- desde(0, S), listaAcotadaDeArboles(S, L).

listaAcotadaDeArboles(0, []).
listaAcotadaDeArboles(S, [X|Xs]) :-
    S > 0,
    between(1, S, N),
    arbolDeN(N, X),
    S2 is S-N,
	listaAcotadaDeArboles(S2, Xs).

arbolDeN(0, nil).
arbolDeN(N, bin(I, _, D)) :-
    N > 0,
    N2 is N-1,
    paresQueSuman(N2, Ni, Nd),
    arbolDeN(Ni, I),
    arbolDeN(Nd, D).

paresQueSuman(S, X, Y) :- between(0, S, X), Y is S-X.

desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).
