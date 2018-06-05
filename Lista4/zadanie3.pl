zapalki(N, KWADRATY) :-
	KWADRATY = (duze(X), srednie(Y), male(Z)),
	!,
	zbuduj_duze(X, [], L1),
	zbuduj_srednie(Y, L1, L2),
	zbuduj_male(Z, L2, L3),
	length(L3, Ilosc_zapalek),
	N is 24 - Ilosc_zapalek,
	duze(X, L3),
	srednie(Y, L3),
	male(Z, L3),
	drukuj(L3).

bazowy([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]).

% duzy kwadrat ma 12 krawedzi, sredni ma 8 krawedzi, a maly 4
duzy_kwadrat([1, 2, 3, 4, 7, 11, 14, 18, 21, 22, 23, 24]).
srednie_kwadraty([[1, 2, 4, 6, 11, 13, 15, 16], [2, 3, 5, 7, 12, 14, 16, 17], [8, 9, 11, 13, 18, 20, 22, 23], [9, 10, 12, 14, 19, 21, 23, 24]]).
male_kwadraty([[1, 4, 5, 8], [2, 5, 6, 9], [3, 6, 7, 10], [8, 11, 12, 15], [9, 12, 13, 16], [10, 13, 14, 17], [15, 18, 19, 22], [16, 19, 20, 23],
			[17, 20, 21, 24]]).

podzbior([], _).
podzbior([H | T1], [H | T2]) :- podzbior(T1, T2).
podzbior([H | T1], [_ | T2]) :- podzbior([H | T1], T2).

podzbior(X, Y, N) :-
	podzbior(X, Y),
	length(X, N).

zbuduj_duze(X, L, Out) :-
	X = 1,
	duzy_kwadrat(Duzy_kwadrat),
	union(Duzy_kwadrat, L, Out).

zbuduj_duze(X, L, Out) :-
	X = 0,
	Out = L.

zbuduj_srednie(Y, L, Out) :-
	srednie_kwadraty(Srednie_kwadraty),
	podzbior(Kwadraty, Srednie_kwadraty, Y),
	zbuduj_srednie(Y, L, Kwadraty, Out).

zbuduj_srednie(0, L, _, Out) :-
	Out = L.
zbuduj_srednie(Y, L, [H | T], Out) :-
	union(H, L, L_nowe),
	Y_nowe is Y - 1,
	zbuduj_srednie(Y_nowe, L_nowe, T, Out).

zbuduj_male(Z, L, Out) :-
	male_kwadraty(Male_kwadraty),
	podzbior(Kwadraty, Male_kwadraty, Z),
	zbuduj_male(Z, L, Kwadraty, Out).

zbuduj_male(0, L, _, Out) :-
	Out = L.
zbuduj_male(Z, L, [H | T], Out) :-
	union(H, L, L_nowe),
	Z_nowe is Z - 1,
	zbuduj_male(Z_nowe, L_nowe, T, Out).

drukuj(L) :-
	bazowy(Bazowy),
	drukuj(Bazowy, L).

drukuj([], _) :- !.

drukuj([H | T], L) :-
	member(H, [2, 3, 9, 10, 16, 17, 23, 24]),
	(
		member(H, L) -> write('---*') ; write('   *')
	),
	drukuj(T, L).

drukuj([H | T], L) :-
	member(H, [1, 8, 15, 22]),
	(
		member(H, L) -> nl, write('*---*') ; nl, write('*   *')
	),
	drukuj(T, L).

drukuj([H | T], L) :-
	member(H, [5, 6, 7, 12, 13, 14, 19, 20, 21]),
	(
		member(H, L) -> write('|   ') ; write('    ')
	),
	drukuj(T, L).

drukuj([H | T], L) :-
	member(H, [4, 11, 18]),
	(
		member(H, L) -> nl, write('|   ') ; nl, write('    ')
	),
	drukuj(T, L).


duze(1, L) :-
	intersection(L, [1, 2, 3, 4, 7, 11, 14, 18, 21, 22, 23, 24], X),
	length(X, N),
	N =:= 12.

duze(0, L) :-
	intersection(L, [1, 2, 3, 4, 7, 11, 14, 18, 21, 22, 23, 24], X),
	length(X, N),
	N =\= 12.

srednie(_, _, C, [], Out) :-
	Out is C.
srednie(Ilosc, L, C, [H | T], Out) :-
	(
		(
			intersection(L, H, X),
			length(X, N),
			N =:= 8
		) ->
		(
			C_nowe is C + 1,
			C_nowe =< Ilosc,
			srednie(Ilosc, L, C_nowe, T, Out)
		)
		;
		(
			C =< Ilosc,
			srednie(Ilosc, L, C, T, Out)
		)
	).

srednie(N, L) :-
	srednie(N, L, 0, [[1, 2, 4, 6, 11, 13, 15, 16], [2, 3, 5, 7, 12, 14, 16, 17], [8, 9, 11, 13, 18, 20, 22, 23], [9, 10, 12, 14, 19, 21, 23, 24]], C),
	N is C.

male(_, _, C, [], Out) :-
	Out is C.
male(Ilosc, L, C, [H | T], Out) :-
	(
		(
			intersection(L, H, X),
			length(X, N),
			N =:= 4
		) ->
		(
			C_nowe is C + 1,
			C_nowe =< Ilosc,
			male(Ilosc, L, C_nowe, T, Out)
		)
		;
		(
			C =< Ilosc,
			male(Ilosc, L, C, T, Out)
		)
	).

male(N, L) :-
	male(N, L, 0, [[1, 4, 5, 8], [2, 5, 6, 9], [3, 6, 7, 10], [8, 11, 12, 15], [9, 12, 13, 16], [10, 13, 14, 17], [15, 18, 19, 22], [16, 19, 20, 23], [17, 20, 21, 24]], C),
	N is C.