% matrices(+LS, -L): es verdadero cuando L es una matriz cuadrada, formada por listas
% de LS (en cualquier orden).
matrices(LS, L) :-
    length(LS, NLS),
    between(1, NLS, N),
    length(L, N),                   % Instancionamos todas las listas L hasta largo <= NLS.
    filasDeLargoN(LS, N, L).        % Cada fila de L tiene que tener largo N y ser una lista de LS.

filasDeLargoN(_, _, []).            % Todas las listas de L=[] tienen largo N.
filasDeLargoN(LS, N, [F|Fs]) :-
    member(F, LS),                  % Pedimos que la fila F sea una lista de LS.
    length(F, N),                   % Tiene que tener largo N para que la matriz sea cuadrada.
    filasDeLargoN(LS, N, Fs),       % El resto de las filas también tienen que ser listas de LS de largo N.
    not((member(F2, Fs), F2 = F)).  % No hay repetidos.

% diagonal(+M, -D)
diagonal([], 0).
diagonal([F|Fs], D) :-
    diagonal(Fs, D2),
    length(Fs, N),
    nth0(N, F, X),
    D is D2+X.

% Versión alternativa con auxiliar.
% diagonal(M, D) :-
%     length(M, N),
%     sumarDiagonal(N, M, D).

% sumarDiagonal(_, [], 0).
% sumarDiagonal(I, [F|Fs], D) :-
%     I > 0,
%     I2 is I-1,
%     sumarDiagonal(I2, Fs, D2),
%     nth1(I, F, X),
%     D is D2+X.

% matrizConDiagonalMayor(+LS, -M)
matrizConDiagonalMayor(LS, M) :-
    matrices(LS, M),
    diagonal(M, D),
    not((matrices(LS, M2), diagonal(M2, D2), D2 > D)).
