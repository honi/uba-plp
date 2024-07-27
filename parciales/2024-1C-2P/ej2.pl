estudiante(knuth).
estudiante(dikstra).
estudiante(lamport).

notas([
    (knuth, plp, 10),
    (knuth, tleng, 10),
    (dikstra, aed3, 3),
    (lamport, analisis, 2),
    (lamport, analisis, 9),
    (lamport, aed3, 10)
]).

tieneMateriaAprobada(E, M) :-
    estudiante(E),
    notas(NS),
    between(4, 10, N),
    member((E, M, N), NS).
    % Se podría primero unificar member y después pedir N >= 4.

eliminarAplazos([], []).
eliminarAplazos([(E,M,N) | NS], [(E,M,N) | LS]) :-
    N >= 4,
    eliminarAplazos(NS, LS).
eliminarAplazos([(E,M,N) | NS], [(E,M,N) | LS]) :-
    N < 4,
    not(tieneMateriaAprobada(E, M)),
    eliminarAplazos(NS, LS).
eliminarAplazos([(E,M,N) | NS], LS) :-
    N < 4,
    tieneMateriaAprobada(E, M),
    eliminarAplazos(NS, LS).

promedio(A, P) :-
    notas(NS1),
    eliminarAplazos(NS1, NS2),
    estudiante(A),
    notasDe(A, NS2, ANS),
    sumlist(ANS, S),
    length(ANS, N),
    P is S / N.

notasDe(_, [], []).
notasDe(A, [(A, _, N)|NS], [N|LS]) :- notasDe(A, NS, LS).
notasDe(A, [(B, _, _)|NS], LS) :- A \= B, notasDe(A, NS, LS).

mejorEstudiante(A) :-
    estudiante(A),
    promedio(A, P),
    not((
        estudiante(B),
        promedio(B, P2),
        P2 > P
    )).
