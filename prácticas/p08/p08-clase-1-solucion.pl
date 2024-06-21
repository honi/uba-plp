
natural(suc(X)) :- natural(X).
natural(cero).


menor(cero,suc(X)) :- natural(X).
menor(suc(X),suc(Y)) :- menor(X,Y).


%entre(1,3,Z).
% Z = 1;
% Z = 2;
% Z = 3;
% false.


entre(X,Y,X) :- X =< Y.
entre(X,Y,Z) :- X < Y, X2 is X+1, entre(X2,Y,Z). 





long([],0).
long([X|XS],N) :- long(XS,N2), N is N2+1.

scr([],[]).
scr([X],[X]).
scr([X,X|XS],L) :- scr([X|XS],L).
scr([X,Y|XS],[X|L]) :- X \= Y, scr([Y|XS],L).

partes([],[]).
partes([X|XS],[X|L]) :- partes(XS,L).
partes([_|XS],L) :- partes(XS,L).

prefijo(L,P) :- append(P,_,L).

insertar(X,L,LX) :- append(I,D,L),append(I,[X|D],LX).

permutacion([],[])
permutacion([X|XS],P) :- permutacion(XS,L), insertar(X,L,P).







