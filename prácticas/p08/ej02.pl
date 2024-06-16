vecino(X, Y, [X|[Y|Ls]]).
vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).

/*
?- vecino(5, Y, [5,6,5,3]).
├─ ?- vecino(5, 6, [5|[6|[5,3]]]).          {X := 5, Y := 6, Ls := [5,3]}
│  └─ true.                                 {Y := 6}
└─ ?- vecino(5, Y, [6,5,3]).                {X := 5, W := 5, Ls := [6,5,3]}
   └─ ?- vecino(5, Y, [5,3]).               {X := 5, W := 6, Ls := [5,3]}
      ├─ ?- vecino(5, 3, [5|[3|[]]]).       {X := 5, Y := 3, Ls := []}
      │  └─ true.                           {Y := 3}
      └─ ?- vecino(5, Y, [3]).              {X := 5, W := 5, Ls := [3]}
         └─ ?- vecino(5, Y, []).            {X := 5, W := 3, Ls := []}
            └─ false.
*/

/*
Si se invierte el orden de las reglas se obtienen los mismos resultados pero en orden
inverso, primero se encuentran los vecinos más al final de la lista y luego se buscan
hacia la izquierda yendo al principio de la lista.
*/
