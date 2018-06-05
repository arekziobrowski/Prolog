usun_pierwszy([_ | T], T).

usun_ostatni([_], []).
usun_ostatni([X | T1], [X | T2]) :-
	usun_ostatni(T1, T2).

srodkowy([X], X).
srodkowy(L, X) :- 
	usun_pierwszy(L, L1),
	usun_ostatni(L1, L2),
	srodkowy(L2, X).
