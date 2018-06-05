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

maksymalny(X) :-
	le(X, X),
	\+ (le(X, Y), X =\= Y).

minimalny(X) :-
	le(X, X),
	\+ (le(Y, X), X =\= Y).

największy(X) :-
	le(X, X),
	\+ (le(Y, Y), \+ le(Y, X)).

najmniejszy(X) :-
	le(X, X),
	\+ (le(Y, Y), \+ le(X, Y)).