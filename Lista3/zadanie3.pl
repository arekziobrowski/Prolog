even_permutation([], []).
even_permutation([H | T], Permutacja) :-
	even_permutation(T, Permutacja1),
	odd_position(H, Permutacja1, Permutacja).
even_permutation([H | T], Permutacja) :-
	odd_permutation(T, Permutacja1),
	even_position(H, Permutacja1, Permutacja).

odd_permutation([H | T], Permutacja) :-
	odd_permutation(T, Permutacja1),
	odd_position(H, Permutacja1, Permutacja).
odd_permutation([H | T], Permutacja) :-
	even_permutation(T, Permutacja1),
	even_position(H, Permutacja1, Permutacja).

even_position(X, [Y | L], [Y, X | L]).
even_position(X, [Y, Z | L1], [Y, Z | L2]) :-
	even_position(X, L1, L2).

odd_position(X, L, [X | L]).
odd_position(X, [Y, Z | L1], [Y, Z | L2]) :-
	odd_position(X, L1, L2).
