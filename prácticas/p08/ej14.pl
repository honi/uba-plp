% coprimos(-X, -Y): genera todos los pares (X,Y) tal que X e Y son coprimos.
coprimos(X, Y) :-
    generarPares(X, Y),     % Generamos todos los pares (X,Y).
    sonCoprimos(X, Y).      % Nos quedamos solo con los que son coprimos.

% generarPares(-X, -Y): genera todos los pares (X,Y).
generarPares(X, Y) :-
    desde(2, S),            % Instanciamos S en todos los números >= 2.
    S2 is S-1,              % Queremos X,Y >= 1.
    between(1, S2, X),      % Instanciamos X entre [1,S-1].
    Y is S-X.               % Como X ya está instanciado podemos calcular Y.

% sonCoprimos(+X, +Y): es verdadero si X e Y son coprimos.
% Dos números son coprimos cuando no comparten divisores > 1.
% Es decir, gcd(X, Y) = 1.
sonCoprimos(X, Y) :- Z is gcd(X, Y), Z =:= 1.

% desde(+X, -Y): instancia Y en todos los números naturales >= X.
desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).
