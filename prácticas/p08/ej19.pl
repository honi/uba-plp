% corteMásParejo(+L,-L1,-L2): dada una lista de números, realiza el corte más parejo
% posible con respecto a la suma de sus elementos (puede haber más de un resultado).

corteMásParejo(L, L1, L2) :-
    unCorte(L, L1, L2, D1),
    not((unCorte(L, _, _, D2), D2 < D1)).

unCorte(L, L1, L2, D) :-
    append(L1, L2, L),
    sum_list(L1, S1),
    sum_list(L2, S2),
    D is abs(S1 - S2).
