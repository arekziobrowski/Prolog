prime(LO, HI, N) :-
	between(LO, HI, N),
	(N = 2;
		(N > 2, X is N - 1, \+ (between(2, X, Y), ((N mod Y) =:= 0)))).