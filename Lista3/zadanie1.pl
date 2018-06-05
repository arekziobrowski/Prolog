wariancja(L, D) :-
	length(L, N),
	wariancja(L, _, 0, N, D1),
	D is D1 / N.

wariancja([], Srednia, Srednia_akum, Dlugosc, D) :-
	Srednia is Srednia_akum / Dlugosc,
	D is 0.

wariancja([H | T], Srednia, Srednia_akum, Dlugosc, D) :-
	Srednia_nowa is Srednia_akum + H,
	wariancja(T, Srednia, Srednia_nowa, Dlugosc, D2),
	D3 is H - Srednia,
	D4 is D3 * D3,
	D is D4 + D2.
