% Un árbol binario se representará en Prolog con:
% nil, si es vacío.
% bin(izq, v, der), donde v es el valor del nodo, izq es el subárbol izquierdo y der es el subárbol derecho.

% vacío(+X)

vacío(nil).

% raiz(+X, ?Y)

raiz(bin(_, V, _), V).

% altura(+X, ?A)

altura(nil, 0).
altura(bin(I, _, D), A) :- altura(I, AI), altura(D, AD), A is 1+max(AI, AD).

% cantidadDeNodos(+X, ?N).

cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(I, _, D), N) :- cantidadDeNodos(I, NI), cantidadDeNodos(D, ND), N is 1+NI+ND.
