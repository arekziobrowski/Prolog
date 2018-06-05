%X jest uporządkowaną listą od 1 do N.
uporzadkowana_lista(N, X) :-
	uporzadkowana_lista(1, N, X).

uporzadkowana_lista(N, N, [N]).
uporzadkowana_lista(Od, Do, [H | T]) :-
	Od < Do,
	H is Od,
	Od_nowe is Od + 1,
	uporzadkowana_lista(Od_nowe, Do, T).

lista(N, X) :-
	uporzadkowana_lista(N, Y),
	parzyste_miejsce([1], [], [1], 2, Y, X).

parzyste_miejsce(Nieparzyste, Parzyste, X, Max, Porzadek, L) :-
	member(Y, Porzadek),
	(
		(
			Y < Max,
			member(Y, Nieparzyste),
			select(Y, Porzadek, Porzadek_nowy),
			append(X, [Y], X_nowy),
			nieparzyste_miejsce(Nieparzyste, Parzyste, X_nowy, Max, Porzadek_nowy, L)
		)
		;
		(
			Y =:= Max,
			Max_nowy is Max + 1,
			append([Y], Parzyste, Parzyste_nowe),
			append(X, [Y], X_nowy),
			nieparzyste_miejsce(Nieparzyste, Parzyste_nowe, X_nowy, Max_nowy, Porzadek, L)
		)
	).


nieparzyste_miejsce(_, _, X, _, [], L) :-
	L = X.
nieparzyste_miejsce(Nieparzyste, Parzyste, X, Max, Porzadek, L) :-
	member(Y, Porzadek),
	(
		(
			Y < Max,
			member(Y, Parzyste),
			select(Y, Porzadek, Porzadek_nowy),
			append(X, [Y], X_nowy),
			parzyste_miejsce(Nieparzyste, Parzyste, X_nowy, Max, Porzadek_nowy, L)
		)
		;
		(
			Y =:= Max,
			Max_nowy is Max + 1,
			append([Y], Nieparzyste, Nieparzyste_nowe),
			append(X, [Y], X_nowy),
			parzyste_miejsce(Nieparzyste_nowe, Parzyste, X_nowy, Max_nowy, Porzadek, L)
		)
	).

