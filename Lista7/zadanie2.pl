:- consult('zadanie1.pl').

split(IN, OUT1, OUT2) :-
	split(IN, OUT1, OUT2, 1).

split(IN, OUT1, OUT2, CHOICE) :- 
	freeze(IN, (
					(
						IN = [H | T] ->
						(
							CHOICE = 1 ->
							(
								OUT1 = [H | OUT1_new],
								split(T, OUT1_new, OUT2, 2)
							)
							;
							(
								OUT2 = [H | OUT2_new],
								split(T, OUT1, OUT2_new, 1)
							)
						)
						;
						(
							OUT1 = [],
							OUT2 = []
						)
					)
				)
		), !.

merge_sort(IN, OUT) :-
	freeze(IN, (
					(
						IN = [H | T] ->
						(
							freeze(T, (
										T = [] ->
										(
											OUT = [H]
										)
										;
										(
											split(IN, O1, O2),
											merge_sort(O1, OUT1),
											merge_sort(O2, OUT2),
											merge(OUT1, OUT2, OUT)
										)
									)
								)
							
						)
						;
						(
							OUT = []
						)

					)
				)
		), !.