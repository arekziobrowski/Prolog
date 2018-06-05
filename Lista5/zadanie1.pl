key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).

sep(';').
sep('+').
sep('-').
sep('*').
sep('/').
sep('(').
sep(')').
sep('<').
sep('>').
sep('=<').
sep('>=').
sep(':=').
sep('=').
sep('/=').

czytaj(Strumien, L1, L2) :-
	get_char(Strumien, X),
	czytaj(Strumien, X, L1, L2).

czytaj(Strumien, X, L1, L2) :-
	(
		(
			char_type(X, lower) -> czytaj_key(Strumien, X, L1, L2)
		)
		;
		(
			char_type(X, upper) -> czytaj_id(Strumien, X, L1, L2)
		)
		;
		(
			char_type(X, digit) -> czytaj_int(Strumien, X, L1, L2)
		)
		;
		(
			char_type(X, space) -> czytaj(Strumien, L1, L2)
		)
		;
		(
			member(X, [';', '+', '-', '*', '(', ')', '<']) -> 
				(
					append([sep(X)], L1, L1_nowy),
					czytaj(Strumien, L1_nowy, L2)
				)
		)
		;
		(
			member(X, [':', '=', '>', '/']) -> 
				(
					separator(Strumien, X, L1, L2)
				)
		)
		;
		(
			char_type(X, end_of_file) -> L2 = L1
		)
	).

%################## KEY #############################	

czytaj_key(Strumien, X, L1, L2) :-
	get_char(Strumien, Y),
	czytaj_key(Strumien, Y, X, L1, L2).

%czytaj_key(A, B, C, D, E):  A - strumien, B - co wczytalismy, C - co juz mamy, D - lista posrednia wynikowa, E - lista wynikowa
czytaj_key(_, end_of_file, A, L1, L2) :-
	key(A),
	append([key(A)], L1, L1_nowy),
	L2 = L1_nowy,
	!.

czytaj_key(Strumien, X, A, L1, L2) :-
	(
		char_type(X, space) -> 
			(
				key(A),
				append([key(A)], L1, L1_nowy),
				czytaj(Strumien, L1_nowy, L2)
			)
	),
	!.

czytaj_key(Strumien, X, A, L1, L2) :-
	(
		member(X, [';', '+', '-', '*', '(', ')', '<']) -> 
			(
				append([sep(X), key(A)], L1, L1_nowy),
				czytaj(Strumien, L1_nowy, L2)
			)
	),
	!.

czytaj_key(Strumien, X, A, L1, L2) :-
	(
		member(X, [':', '=', '>', '/']) -> 
			(
				append([key(A)], L1, L1_nowy),
				separator(Strumien, X, L1_nowy, L2)
			)
	),
	!.

czytaj_key(Strumien, X, A, L1, L2) :-
	(
		char_type(X, lower) -> 
			(
				get_char(Strumien, Y),
				atom_concat(A, X, A_nowy),
				czytaj_key(Strumien, Y, A_nowy, L1, L2)
			)
	).

%################## INT #############################

czytaj_int(Strumien, X, L1, L2) :-
	get_char(Strumien, Y),
	czytaj_int(Strumien, Y, X, L1, L2).

czytaj_int(_, end_of_file, A, L1, L2) :-
	append([int(A)], L1, L1_nowy),
	L2 = L1_nowy,
	!.

czytaj_int(Strumien, X, A, L1, L2) :-
	(
		char_type(X, space) -> 
			(
				append([int(A)], L1, L1_nowy),
				czytaj(Strumien, L1_nowy, L2)
			)
	),
	!.

czytaj_int(Strumien, X, A, L1, L2) :-
	(
		member(X, [';', '+', '-', '*', '(', ')', '<']) -> 
			(
				append([sep(X), int(A)], L1, L1_nowy),
				czytaj(Strumien, L1_nowy, L2)
			)
	),
	!.

czytaj_int(Strumien, X, A, L1, L2) :-
	(
		member(X, [':', '=', '>', '/']) -> 
			(
				append([int(A)], L1, L1_nowy),
				separator(Strumien, X, L1_nowy, L2)
			)
	),
	!.

czytaj_int(Strumien, X, A, L1, L2) :-
	(
		char_type(X, digit) -> 
			(
				get_char(Strumien, Y),
				atom_concat(A, X, A_nowy),
				czytaj_int(Strumien, Y, A_nowy, L1, L2)
			)
	).

%################## ID #############################

czytaj_id(Strumien, X, L1, L2) :-
	get_char(Strumien, Y),
	czytaj_id(Strumien, Y, X, L1, L2).

czytaj_id(_, end_of_file, A, L1, L2) :-
	append([id(A)], L1, L1_nowy),
	L2 = L1_nowy,
	!.

czytaj_id(Strumien, X, A, L1, L2) :-
	(
		char_type(X, space) -> 
			(
				append([id(A)], L1, L1_nowy),
				czytaj(Strumien, L1_nowy, L2)
			)
	),
	!.

czytaj_id(Strumien, X, A, L1, L2) :-
	(
		member(X, [';', '+', '-', '*', '(', ')', '<']) -> 
			(
				append([sep(X), id(A)], L1, L1_nowy),
				czytaj(Strumien, L1_nowy, L2)
			)
	),
	!.

czytaj_id(Strumien, X, A, L1, L2) :-
	(
		member(X, [':', '=', '>', '/']) -> 
			(
				append([id(A)], L1, L1_nowy),
				separator(Strumien, X, L1_nowy, L2)
			)
	),
	!.

czytaj_id(Strumien, X, A, L1, L2) :-
	(
		char_type(X, upper) -> 
			(
				get_char(Strumien, Y),
				atom_concat(A, X, A_nowy),
				czytaj_id(Strumien, Y, A_nowy, L1, L2)
			)
	).

%################## SEP #############################

separator(Strumien, X, L1, L2) :-
	get_char(Strumien, Y),
	atom_concat(X, Y, Concat),
	(
		sep(Concat) -> 
			(
				append([sep(Concat)], L1, L1_nowy),
				czytaj(Strumien, L1_nowy, L2)
			)
			;
			(
				sep(X),
				append([sep(X)], L1, L1_nowy),
				czytaj(Strumien, Y, L1_nowy, L2)
			)
	).

scanner(Strumien, Tokeny) :-
	czytaj(Strumien, [], L),
	reverse(L, Tokeny).