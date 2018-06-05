le(1, 2).
le(1, 1).
le(2, 2).
le(2, 3).
le(1, 3).
le(3, 3).
le(1, 4).
le(2, 4).
le(3, 4).
le(4, 4).

zwrotność :- \+ ((le(X, _); le(_, X)), \+ le(X, X)).
przechodniość :- \+ ((le(X, Y), le(Y, Z)), \+ le(X, Z)).
słaba_antysymetria :- \+ ((le(X, Y), le(Y, X)), X =\= Y).

częściowy_porządek :- zwrotność, przechodniość, słaba_antysymetria.