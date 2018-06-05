max_sum(L, S) :-
	max_sum(L, 0, 0, S).

max_sum([], _, Max, S) :-
	S is Max.
max_sum([H | T], MaxH, MaxSF, S) :-
	Nowy is MaxH + H,
	(Nowy > MaxSF -> MaxSF_temp is Nowy; MaxSF_temp is MaxSF),
	(Nowy < 0 -> MaxH_temp is 0; MaxH_temp is Nowy),
	max_sum(T, MaxH_temp, MaxSF_temp, S).
