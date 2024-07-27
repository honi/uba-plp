%%%%%%%%%%%%%%%%%%%%%%%%
%% Tablero
%%%%%%%%%%%%%%%%%%%%%%%%

%% Ejercicio 1
%% tablero(+Filas,+Columnas,-Tablero) instancia una estructura de tablero en blanco
%% de Filas x Columnas, con todas las celdas libres.
tablero(F, C, T) :-
  var(T),     % Caso disjunto con tablero(-F, -C, +T).
  findall(X, (betweenOpen(0, F, _), length(X, C)), T).  % T unifica con F listas de longitud C.

% Agregamos estas reglas para poder revertir tablero.
% Queremos usar tablero(-F, -C, +T) para averiguar el tamaño de un tablero.
tablero(0, 0, []).
tablero(F, C, T) :-
  nonvar(T),      % Caso disjunto con tablero(+F, +C, -T).
  length(T, F),   % Instanciamos F.
  F > 0,
  nth0(0, T, F0),
  length(F0, C),  % Instanciamos C a partir de la primer file.
  % Unificamos solo si todas las filas tienen la misma longitud.
  forall(betweenOpen(0, F, X), (nth0(X, T, F0), length(F0, C))).

%% Ejercicio 2
%% ocupar(+Pos,?Tablero) será verdadero cuando la posición indicada esté ocupada.
ocupar(pos(F,C), T) :- nth0(F, T, FT), nth0(C, FT, ocupada).

%% Ejercicio 3
%% vecino(+Pos, +Tablero, -PosVecino) será verdadero cuando PosVecino sea
%% un átomo de la forma pos(F',C') y pos(F',C') sea una celda contigua a
%% pos(F,C), donde Pos=pos(F,C). Las celdas contiguas puede ser a lo sumo cuatro
%% dado que el robot se moverá en forma ortogonal.
vecino(pos(X,Y), T, pos(X2,Y2)) :-
  tablero(F, C, T),                     % Unificamos F y C a partir de T.
  genPosVecinos(pos(X,Y), pos(X2,Y2)),  % Generamos todos los vecinos de pos(X,Y).
  betweenOpen(0, F, X2),                % X2 es una fila válida.
  betweenOpen(0, C, Y2).                % Y2 es una columna válida.

% genPosVecinos(+P1, -P2) genera las 4 posiciones vecinas de P1.
genPosVecinos(pos(X1,Y1), pos(X2,Y2)) :-
  X1l is X1-1, X1h is X1+1, between(X1l, X1h, X2),
  Y1l is Y1-1, Y1h is Y1+1, between(Y1l, Y1h, Y2),
  DX is abs(X1-X2),
  DY is abs(Y1-Y2),
  DX+DY =:= 1.    % Solo nos movemos ortogonalmente (es decir no vale en diagonal).

%% Ejercicio 4
%% vecinoLibre(+Pos, +Tablero, -PosVecino) idem vecino/3 pero además PosVecino
%% debe ser una celda transitable (no ocupada) en el Tablero
vecinoLibre(pos(X1,Y1), T, pos(X2,Y2)) :-
  vecino(pos(X1,Y1), T, pos(X2,Y2)),    % pos(X2,Y2) es un vecino de pos(X1,Y1).
  nth0(X2, T, F),
  nth0(Y2, F, Z),                       % Z es la celda en pos(X2,Y2).
  var(Z).                               % Al ser una variable la celda está libre.

%% posLibre(+Pos, +Tablero) unifica a true si Pos es una posición libre en T.
%% Lo usamos más adelante en camino.
posLibre(pos(X,Y), T) :-
  nth0(X, T, F),
  nth0(Y, F, Z),                        % Z es la celda en pos(X,Y).
  var(Z).                               % Al ser una variable la celda está libre.

%%%%%%%%%%%%%%%%%%%%%%%%
%% Definicion de caminos
%%%%%%%%%%%%%%%%%%%%%%%%

%% Ejercicio 5
%% camino(+Inicio, +Fin, +Tablero, -Camino) será verdadero cuando Camino sea una lista
%% [pos(F1,C1), pos(F2,C2),..., pos(Fn,Cn)] que denoten un camino desde Inicio
%% hasta Fin pasando solo por celdas transitables.
%% Además se espera que Camino no contenga ciclos.
%% Notar que la cantidad de caminos es finita y por ende se tiene que poder recorrer
%% todas las alternativas eventualmente.
%% Consejo: Utilizar una lista auxiliar con las posiciones visitadas

camino(I, F, T, C) :-
  posLibre(I, T),                   % Si la posición inicial no está libre entonces no hay camino.
  caminoAux(I, F, T, [I], C).       % Obtenemos un camino desde I hasta F.

caminoAux(I, F, T, V1, C) :-
  I \= F,                           % Queda camino por recorrer, necesitamos reglas disjuntas.
  vecinoLibre(I, T, VL),            % vecinoLibre solo devuelve posiciones válidas y desocupadas.
  not(member(VL, V1)),              % No se eligen posiciones ya visitadas.
  append(V1, [VL], V2),
  caminoAux(VL, F, T, V2, C).       % Pasamos por la posición VL y vemos el camino desde VL hasta F.

caminoAux(F, F, _, C, C).           % Llegamos al final.

%% 5.1. Analizar la reversibilidad de los parámetros Fin y Camino justificando adecuadamente en cada
%% caso por qué el predicado se comporta como lo hace.

% El parámetro C es reversible. Es decir, podemos preguntar si C es un camino desde I
% hasta F en T. caminoAux unifica paso a paso la lista de vecinos visitados V1/V2
% hasta llegar a F, donde se unifica C con la lista de los vecinos visitados (el camino
% propiamente dicho). Si C ya viene instanciada, en esencia estamos preguntando si C es
% un camino desde I hasta F. Hay solo 2 opciones (excluyentes): o bien obtenemos una
% lista de vecinos que unifica a C, y en tal caso C efectivamente es un camino desde I
% hasta F, o bien no podemos unificar C con ninguna lista de vecinos visitados, y en tal
% caso C no era un camino desde I hasta F.

% F no es reversible. Si lo intentamos, vamos a obtener F=I y el camino trivial C=[I].
% Pero al pedir más soluciones, backtrackeamos y entramos en la otra regla de caminoAux.
% Al pedir I \= F no logramos ninguna unificación y no obtenemos ningún otro camino.
% Esto sucede porque F es una variable sin ninguna restricción, le falta información
% para poder instanciarse y unificar con algo distinto de I.

% Podemos hacer F reversible si primero le restringimos el universo de posibles valores.

caminoReversible(I, F, T, C) :-
  posLibre(I, T),
  caminoAuxReversible(I, F, T, [I], C).

caminoAuxReversible(I, pos(X,Y), T, V1, C) :-
  tablero(Filas, Cols, T),
  betweenOpen(0, Filas, X),
  betweenOpen(0, Cols, Y),
  I \= pos(X,Y),      % Ahora X e Y están instanciadas y podemos ver si unifica o no con I.
  vecinoLibre(I, T, VL),
  not(member(VL, V1)),
  append(V1, [VL], V2),
  caminoAuxReversible(VL, pos(X,Y), T, V2, C).

caminoAuxReversible(F, F, _, C, C).

%% Ejercicio 6
%% camino2(+Inicio, +Fin, +Tablero, -Camino) ídem camino/4 pero que las soluciones
%% se instancien en orden creciente de longitud.
camino2(I, F, T, C) :-
  tablero(Fs, Cs, T),     % Unificamos Fs y Cs a partir de T.
  M is Fs*Cs,             % Longitud máxima de un camino.
  between(1, M, N),       % Por cada longitud admisible.
  camino(I, F, T, C),     % Generamos todos los caminos.
  length(C, N).           % Testeamos que tengan longitud N.

%% 6.1. Analizar la reversibilidad de los parámetros Inicio y Camino justificando adecuadamente en
%% cada caso por qué el predicado se comporta como lo hace.

% C es reversible por la misma razón ya explicada en camino/4. Agregando que si C es
% realmente un camino desde I hasta F, entonces tiene alguna longitud 1 <= N <= Max.
% Por lo tanto eventualmente camino2Aux va a instanciar a N en la longitud correcta.

% Análogamente sucede lo mismo con I. Al no estar instanciado no podemos unificar I \= F
% en caminoAux. Se podría arreglar de la misma forma que hicimos en caminoReversible.

%% Ejercicio 7
%% caminoOptimo(+Inicio, +Fin, +Tablero, -Camino) será verdadero cuando Camino sea un
%% camino óptimo sobre Tablero entre Inicio y Fin. Notar que puede no ser único.
caminoOptimo(I, F, T, C) :-
  camino2(I, F, T, C),                                % C es un camino de largo óptimo.
  length(C, N),                                       % N es el largo óptimo.
  not((camino(I, F, T, C2), length(C2, N2), N2 < N)). % No existe otro camino más corto que C.

%%%%%%%%%%%%%%%%%%%%%%%%
%% Tableros simultáneos
%%%%%%%%%%%%%%%%%%%%%%%%

%% Ejercicio 8
%% caminoDual(+Inicio, +Fin, +Tablero1, +Tablero2, -Camino) será verdadero
%% cuando Camino sea un camino desde Inicio hasta Fin pasando al mismo tiempo
%% sólo por celdas transitables de ambos tableros.
caminoDual(I, F, T1, T2, C) :-
  camino(I, F, T1, C),
  camino(I, F, T2, C).

% Como camino/4 puede revertir C, primero instanciamos un camino C en T1, y si existe,
% lo usamos para verificar que C también sea un camino en T2.

%%%%%%%%%%%%%
%% Auxiliares
%%%%%%%%%%%%%

% betweenOpen(+X, +Y, -N) unifica a true si N está en el intervalo [X, Y).
betweenOpen(X, Y, N) :- Y1 is Y-1, between(X, Y1, N).

%%%%%%%%%%%%%%%%%
%% TESTS: tablero
%%%%%%%%%%%%%%%%%

tablero(ocupada_centro_3x3, T) :- tablero(3, 3, T), ocupar(pos(1,1), T).

tablero(ocupada_mas_3x3, T) :-
  tablero(3, 3, T),
  ocupar(pos(1,0), T), ocupar(pos(1,1), T), ocupar(pos(1,2), T),
  ocupar(pos(0,1), T), ocupar(pos(1,1), T), ocupar(pos(2,1), T).

tablero(enunciado_5x5, T) :-
  tablero(5, 5, T),
  ocupar(pos(1,1), T),
  ocupar(pos(1,2), T).

cantidadTestsTablero(7).

testTablero(1) :- tablero(0, 0, []).
testTablero(2) :- tablero(3, 3, [[_,_,_],[_,_,_],[_,_,_]]).
testTablero(3) :- tablero(3, 1, [[_],[_],[_]]).
testTablero(4) :- tablero(1, 3, [[_,_,_]]).
testTablero(5) :- ocupar(pos(0,0), [[ocupada]]).
testTablero(6) :- tablero(ocupada_centro_3x3, [[_,_,_],[_,ocupada,_],[_,_,_]]).
testTablero(7) :- tablero(ocupada_mas_3x3, [[_,ocupada,_],[ocupada,ocupada,ocupada],[_,ocupada,_]]).

%%%%%%%%%%%%%%%%
%% TESTS: vecino
%%%%%%%%%%%%%%%%

cantidadTestsVecino(13).

% No nos importa en qué orden se instancian las soluciones,
% entonces ordenamos los resultados para poder compararlos de forma determinística con el resultado esperado.
testVecinoAux(P, T, EPs) :- findall(X, vecino(P, T, X), Ps), sort(Ps, EPs).
testVecinoLibreAux(P, T, EPs) :- findall(X, vecinoLibre(P, T, X), Ps), sort(Ps, EPs).

% Casos exhaustivos para testear que vecino/3 siempre instancia posiciones adentro del tablero.
testVecino(1) :- tablero(3, 3, T), testVecinoAux(pos(0,0), T, [pos(0,1), pos(1,0)]).                      % top-left
testVecino(2) :- tablero(3, 3, T), testVecinoAux(pos(0,2), T, [pos(0,1), pos(1,2)]).                      % top-right
testVecino(3) :- tablero(3, 3, T), testVecinoAux(pos(2,2), T, [pos(1,2), pos(2,1)]).                      % bottom-right
testVecino(4) :- tablero(3, 3, T), testVecinoAux(pos(2,0), T, [pos(1,0), pos(2,1)]).                      % bottom-left
testVecino(5) :- tablero(3, 3, T), testVecinoAux(pos(0,1), T, [pos(0,0), pos(0,2), pos(1,1)]).            % top-center
testVecino(6) :- tablero(3, 3, T), testVecinoAux(pos(2,1), T, [pos(1,1), pos(2,0), pos(2,2)]).            % bottom-center
testVecino(7) :- tablero(3, 3, T), testVecinoAux(pos(1,0), T, [pos(0,0), pos(1,1), pos(2,0)]).            % left-center
testVecino(8) :- tablero(3, 3, T), testVecinoAux(pos(1,2), T, [pos(0,2), pos(1,1), pos(2,2)]).            % right-center
testVecino(9) :- tablero(3, 3, T), testVecinoAux(pos(1,1), T, [pos(0,1), pos(1,0), pos(1,2), pos(2,1)]).  % center

% Tablero vacío (no tiene mucho sentido pero lo testeamos igual).
testVecino(10) :-
  tablero(1, 1, T),
  testVecinoAux(pos(0,0), T, []).

% Todos los vecinos están libres.
testVecino(11) :-
  tablero(3, 3, T),
  testVecinoLibreAux(pos(1,1), T, [pos(0,1), pos(1,0), pos(1,2), pos(2,1)]).

% Los vecinos ocupados no están libres.
testVecino(12) :-
  tablero(ocupada_centro_3x3, T),
  testVecinoLibreAux(pos(0,1), T, [pos(0,0), pos(0,2)]).

% No hay vecinos libres.
testVecino(13) :-
  tablero(ocupada_mas_3x3, T),
  testVecinoLibreAux(pos(0,0), T, []).

%%%%%%%%%%%%%%%%
%% TESTS: camino
%%%%%%%%%%%%%%%%

cantidadTestsCamino(6).
testCaminoAux(I, F, T, ECs) :- findall(X, camino(I, F, T, X), Cs), sort(Cs, ECs).
testCamino2Aux(I, F, T, ECs) :- findall(X, camino2(I, F, T, X), ECs).

% Caso sencillo sin posiciones ocupadas.
testCamino(1) :-
  tablero(2, 2, T),
  testCaminoAux(pos(0,0), pos(1,1), T, [
    [pos(0,0), pos(0,1), pos(1,1)],
    [pos(0,0), pos(1,0), pos(1,1)]
  ]).

% Las posiciones ocupadas restringen los caminos posibles.
% No podemos pasar por posiciones ocupadas.
testCamino(2) :-
  tablero(ocupada_centro_3x3, T),
  testCaminoAux(pos(0,0), pos(2,2), T, [
    [pos(0,0), pos(0,1), pos(0,2), pos(1,2), pos(2,2)],
    [pos(0,0), pos(1,0), pos(2,0), pos(2,1), pos(2,2)]
  ]).

% No hay camino.
testCamino(3) :-
  tablero(ocupada_mas_3x3, T),
  testCaminoAux(pos(0,0), pos(2,2), T, []).

% La posición de inicio está ocupada.
testCamino(4) :-
  tablero(ocupada_centro_3x3, T),
  testCaminoAux(pos(1,1), pos(2,2), T, []).

% Hay un montón de caminos.
testCamino(5) :-
  tablero(enunciado_5x5, T),
  testCaminoAux(pos(0,0), pos(2,3), T, Cs),
  length(Cs, 287).

% camino2/4 usa camino/4, así que sólo testeamos que camino2/4
% instancie los caminos en el orden correcto.
testCamino(6) :-
  tablero(2, 2, T),
  testCamino2Aux(pos(0,1), pos(1,1), T, [
    [pos(0,1), pos(1,1)],
    [pos(0,1), pos(0,0), pos(1,0), pos(1,1)]
  ]).

%%%%%%%%%%%%%%%%%%%%%%
%% TESTS: caminoOptimo
%%%%%%%%%%%%%%%%%%%%%%

cantidadTestsCaminoOptimo(3).
testCaminoOptimoAux(I, F, T, ECs) :- findall(X, caminoOptimo(I, F, T, X), Cs), sort(Cs, ECs).

% Un solo camino óptimo.
testCaminoOptimo(1) :-
  tablero(2, 2, T),
  testCaminoOptimoAux(pos(0,1), pos(1,1), T, [
    [pos(0,1), pos(1,1)]
  ]).

% Los únicos caminos son óptimos.
testCaminoOptimo(2) :-
  tablero(2, 2, T),
  testCaminoOptimoAux(pos(0,0), pos(1,1), T, [
    [pos(0,0), pos(0,1), pos(1,1)],
    [pos(0,0), pos(1,0), pos(1,1)]
  ]).

% Caso con tablero más grandes y muchos caminos no óptimos.
testCaminoOptimo(3) :-
  tablero(enunciado_5x5, T),
  testCaminoOptimoAux(pos(0,0), pos(2,3), T, [
    [pos(0,0), pos(0,1), pos(0,2), pos(0,3), pos(1,3), pos(2,3)],
    [pos(0,0), pos(1,0), pos(2,0), pos(2,1), pos(2,2), pos(2,3)]
  ]).

%%%%%%%%%%%%%%%%%%%%
%% TESTS: caminoDual
%%%%%%%%%%%%%%%%%%%%

cantidadTestsCaminoDual(4).
testCaminoDualAux(T1, T2, I, F, ECs) :- findall(X, caminoDual(I, F, T1, T2, X), Cs), sort(Cs, ECs).

% Mismos tableros.
testCaminoDual(1) :-
  tablero(2, 2, T1),
  tablero(2, 2, T2),
  testCaminoDualAux(T1, T2, pos(0,0), pos(1,1), [
    [pos(0,0), pos(0,1), pos(1,1)],
    [pos(0,0), pos(1,0), pos(1,1)]
  ]).

% Un camino descartado por posición ocupada en T1.
testCaminoDual(2) :-
  tablero(2, 2, T1),
  tablero(2, 2, T2),
  ocupar(pos(0,1), T1),
  testCaminoDualAux(T1, T2, pos(0,0), pos(1,1), [
    [pos(0,0), pos(1,0), pos(1,1)]
  ]).

% Ambos caminos descartados por posición ocupadas en T1 y T2.
testCaminoDual(3) :-
  tablero(2, 2, T1),
  tablero(2, 2, T2),
  ocupar(pos(0,1), T1),
  ocupar(pos(1,0), T2),
  testCaminoDualAux(T1, T2, pos(0,0), pos(1,1), []).

% Posición inalcanzable en T1.
testCaminoDual(4) :-
  tablero(2, 2, T1),
  tablero(3, 3, T2),
  testCaminoDualAux(T1, T2, pos(0,0), pos(2,2), []).

%%%%%%%%
%% TESTS
%%%%%%%%

tests(tablero) :- cantidadTestsTablero(M), forall(between(1, M, N), testTablero(N)).
tests(vecino) :- cantidadTestsVecino(M), forall(between(1, M, N), testVecino(N)).
tests(camino) :- cantidadTestsCamino(M), forall(between(1, M, N), testCamino(N)).
tests(caminoOptimo) :- cantidadTestsCaminoOptimo(M), forall(between(1, M, N), testCaminoOptimo(N)).
tests(caminoDual) :- cantidadTestsCaminoDual(M), forall(between(1, M, N), testCaminoDual(N)).

tests(todos) :-
  tests(tablero),
  tests(vecino),
  tests(camino),
  tests(caminoOptimo),
  tests(caminoDual).

tests :- tests(todos).
