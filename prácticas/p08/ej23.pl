:- discontiguous nodos/2.
:- discontiguous aristas/2.

% Grafo trivial.
nodos(g1, [1]).
aristas(g1, []).

% Grafo simple.
nodos(g2, [1,2,3,4]).
aristas(g2, [(1,2), (2,3), (1,3), (3,4)]).

% Grafo con un ciclo.
nodos(g3, [1,2,3,4]).
aristas(g3, [(1,2), (2,3), (1,3), (3,4), (4,1)]).

% Grafo disconexo.
nodos(g4, [1,2,3,4]).
aristas(g4, [(1,2), (3,4)]).

% Grafo disconexo trivial.
nodos(g5, [1,2]).
aristas(g5, []).

% Grafo extrella.
nodos(g6, [1,2,3,4]).
aristas(g6, [(1,2), (1,3), (1,4)]).

esNodo(G, N) :- nodos(G, Ns), member(N, Ns).

esArista(G, N1, N2) :-
    esNodo(G, N1),
    esNodo(G, N2),
    aristas(G, As),
    member((N1, N2), As).

esArista(G, N1, N2) :-
    esNodo(G, N1),
    esNodo(G, N2),
    aristas(G, As),
    not(member((N1, N2), As)),
    member((N2, N1), As).

% caminoSimple(+G, +D, +H, ?L)
caminoSimple(G, D, H, L) :- caminoSimpleAux(G, D, H, L, [D]).

% caminoSimpleAux(+G, +D, +H, ?L, -V).
caminoSimpleAux(G, D, D, L, L) :- esNodo(G, D).
caminoSimpleAux(G, D, H, L, V) :-
    esNodo(G, D),
    esArista(G, D, D2),
    not(member(D2, V)),
    append(V, [D2], V2),
    caminoSimpleAux(G, D2, H, L, V2).

% caminoHamiltoniano(+G, ?L)
caminoHamiltoniano(G, L) :-
    caminoSimple(G, _, _, L),
    not((esNodo(G, N), not(member(N, L)))).

% esConexo(+G)
esConexo(G) :-
    not((
        esNodo(G, N1),
        esNodo(G, N2),
        N1 \= N2,
        not(caminoSimple(G, N1, N2, _))
    )).

% esEstrella(+G)
esEstrella(G) :-
    esConexo(G),
    esNodo(G, N1).
    % No me salió :(
