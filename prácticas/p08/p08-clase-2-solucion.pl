iesimo(0,[X|_],X).
iesimo(I,[_|XS],X) :- iesimo(I2,XS,X), I is I2 + 1.

desde2(X,X).
desde2(X,Y) :- var(Y), N is X+1, desde2(N,Y).
desde2(X,Y) :- nonvar(Y), X < Y.

pmq(X,Y) :- between(0,X,Y), Y mod 2 =:= 0.

paresSuman(S,X,Y) :- S1 is S-1, between(1,S1,X), Y is S-X.  

generarPares(X,Y) :- desde2(2,S), paresSuman(S,X,Y).

coprimos(X,Y) :- generarPares(X,Y), gcd(X,Y) =:= 1. 


altaMateria(plp).
altaMateria(aa).
altaMateria(metnum).

liviana(plp).
liviana(aa).
liviana(eci).

obligatoria(plp).
obligatoria(metnum).

leGusta(M) :- altaMateria(M).
leGusta(M) :- liviana(M).

hacer(M) :- leGusta(M), obligatoria(M).

hacerV2(M) :- setof(X,(leGusta(X),obligatoria(X)),L), member(M,L).


% corteMasParejo(+L,-L1,-L2)
corteMasParejo(L,L1,L2) :- unCorte(L,L1,L2,D), not((unCorte(L,_,_,D2), D2 < D)).

unCorte(L,L1,L2,D) :- append(L1,L2,L), sumlist(L1,S1), sumlist(L2,S2), D is abs(S1-S2).



esTriangulo(tri(A,B,C)) :- A < B+C, B < A+C, C < B+A.


perimetro(tri(A,B,C),P) :- ground(tri(A,B,C)), esTriangulo(tri(A,B,C)), P is A+B+C.
perimetro(tri(A,B,C),P) :- not(ground(tri(A,B,C))), armarTriplas(P,A,B,C), esTriangulo(tri(A,B,C)).



armarTriplas(P,A,B,C) :- desde2(3,P), between(0,P,A), S is P-A, between(0,S,B), C is S-B.



triangulos(T) :- perimetro(T,_).
