wyrazenie(L, V, E) :-
	wyrazenie2(L, V, E),
	V is E.

niepusta([_ | _]).

wyrazenie2([H], _, H).
wyrazenie2(L, _, X) :-
	append(L1, L2, L),
	niepusta(L1),
	niepusta(L2),
	wyrazenie2(L1, _, Z),
	wyrazenie2(L2, _, Y),
	(
		X = Z + Y;
		X = Z - Y;
		X = Z * Y;
		\+ (0 is Y; 0.0 is Y) -> X = Z / Y
	).
