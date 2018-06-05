jednokrotnie(X, L) :-
	append(L1, [X | L2], L),
	\+ member(X, L1),
	\+ member(X, L2).

dwukrotnie(X, L) :-
	append(L1, [X | L2], L),
	\+ member(X, L1),
	jednokrotnie(X, L2).
