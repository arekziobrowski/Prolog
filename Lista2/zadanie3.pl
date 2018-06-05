arc(a, b).
arc(b, a).
arc(b, c).
arc(c, d).

przejscie(X, X, []).
przejscie(X, Y, V) :-
	arc(X, Z),
	\+ member(Z, V),
	(
		Y = Z
		;
		przejscie(Z, Y, [X | V])
	).

osiagalny(X, Y) :-
	przejscie(X, Y, []).
