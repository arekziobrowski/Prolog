ma(osoba1, rzecz1).
ma(osoba2, rzecz2).
ma(osoba3, rzecz3).
ma(osoba4, rzecz4).
ma(sknera, rzecz5).

/*	
				0			1					2					3							4					5
	________|___________|___________________|___________________|___________________________|___________________|________________________
	osoba1	|	rzecz1	|	-				|	-				|	-						|	rzecz1			|	-	
	osoba2	|	rzecz2	|	rzecz2, rzecz1	|	rzecz2			|	rzecz2					|	rzecz2			|	rzecz2
	osoba3	|	rzecz3	|	rzecz3			|	rzecz1			|	-						|	-				|	-
	osoba4	|	rzecz4	|	rzecz4			|	rzecz4, rzecz3	|	rzecz4, rzecz3, rzecz1	|	rzecz3			|	rzecz3
	sknera	|	rzecz5  |	rzecz5			|	rzecz5			|	rzecz5					|	rzecz5, rzecz4	|	rzecz5, rzecz4, rzecz1
*/

daje([t], osoba1, rzecz1, osoba2).
daje([t, t], osoba2, rzecz1, osoba3).
daje([t, t], osoba3, rzecz3, osoba4).
daje([t, t, t], osoba3, rzecz1, osoba4).
daje([t, t, t, t], osoba4, rzecz4, sknera).
daje([t, t, t, t], osoba4, rzecz1, osoba1).
daje([t, t, t, t, t], osoba1, rzecz1, sknera).

ma([], Kto, Co) :-
	ma(Kto, Co).
ma(Kiedy, Kto, Co) :-
	ma(_, Co),
	(
		daje(Kiedy, _, Co, Kto)
		;
		(
			wczesniej(Kiedy, Wczesniej),
			\+ daje(Kiedy, _, Co, _),
			ma(Wczesniej, Kto, Co)
		)
	).


wczesniej([], _) :-
	false.
wczesniej(Teraz, Wczesniej) :-
	append(Wczesniej, [t], Teraz).