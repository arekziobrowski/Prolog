board(L) :-
	length(L, N),
	reverse(L, K),
	pozioma_linia(N),
	(
		0 is N mod 2 -> bialy_rzad(N, 1, K) ; czarny_rzad(N, 1, K)
	).

pozioma_linia(N) :-
	write("+"),
	pozioma_linia(N, N).

pozioma_linia(_, 0):- nl, !.

pozioma_linia(N, C) :-
	write("-----+"),
	C_nowe is C - 1,
	pozioma_linia(N, C_nowe).

bialy_rzad(N, N, [H | _]) :-
	linia(N, H, bialy),
	linia(N, H, bialy),
	pozioma_linia(N),
	!.

bialy_rzad(N, C, [H | T]) :-
	linia(N, H, bialy),
	linia(N, H, bialy),
	pozioma_linia(N),
	C_nowe is C + 1,
	czarny_rzad(N, C_nowe, T).

czarny_rzad(N, N, [H | _]) :-
	linia(N, H, czarny),
	linia(N, H, czarny),
	pozioma_linia(N),
	!.

czarny_rzad(N, C, [H | T]) :-
	linia(N, H, czarny),
	linia(N, H, czarny),
	pozioma_linia(N),
	C_nowe is C + 1,
	bialy_rzad(N, C_nowe, T).

linia(N, H, Kolor) :-
	write("|"),
	linia(N, 1, H, Kolor).

linia(N, N, H, bialy) :-
	(
		N = H -> write(" ### |") ; write("     |")
	),
	nl,
	!.

linia(N, C, H, bialy) :-
	(
		C = H -> write(" ### |") ; write("     |")
	),
	C_nowe is C + 1,
	linia(N, C_nowe, H, czarny).

linia(N, N, H, czarny) :-
	(
		N = H -> write(":###:|") ; write(":::::|")
	),
	nl,
	!.

linia(N, C, H, czarny) :-
	(
		C = H -> write(":###:|") ; write(":::::|")
	),
	C_nowe is C + 1,
	linia(N, C_nowe, H, bialy).


hetmany(N, P) :-
	numlist(1, N, L),
	permutation(L, P),
	dobra(P).

dobra(P) :-
	\+ zla(P).

zla(P) :-
	append(_, [Wi | L1], P),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K + 1.

