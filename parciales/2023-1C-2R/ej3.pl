frutal(frutilla).
frutal(banana).
cremoso(banana).
cremoso(americana).
cremoso(frutilla).
leGusta(X) :- frutal(X), cremoso(X).
cucurucho(X, Y) :- leGusta(X), leGusta(Y).
