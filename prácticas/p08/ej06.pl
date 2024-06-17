% aplanar(+Xs, -Ys)

aplanar([], []).

% Caso: en la cabeza hay una lista.
aplanar([Zs|Xs], Ys) :-
    aplanar(Zs, AZs),       % AZs es la lista Zs aplanada.
    aplanar(Xs, Rs),        % Aplanar recursivamente.
    append(AZs, Rs, Ys).    % Ys son todos los elementos de AZs seguidos de los de Rs.

% Caso: en la cabeza hay algo que no es una lista.
aplanar([X|Xs], Ys) :-
    not(aplanar(X, _)),     % Si X no se puede aplanar entonces no es una lista.
    aplanar(Xs, Rs),        % Aplanar recursivamente.
    append([X], Rs, Ys).    % Ys es X seguido de todos los elementos de Rs.
